//
//  PlayerViewController.swift
//  NavigationNET
//
//  Created by beshssg on 21.10.2021.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    // MARK: - Track switch:
    private enum TrackSwitchDirection {
        case previous
        case next
    }

    // MARK: - UIProperties
    private var player = AVAudioPlayer()
    
    private let playlist = PlaylistProvider.playlist
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play"), for: .normal)
        button.addTarget(self, action: #selector(startPlaying), for: .touchUpInside)
        return button
    }()
    
    private lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "stop"), for: .normal)
        button.addTarget(self, action: #selector(stopPlaying), for: .touchUpInside)
        return button
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward"), for: .normal)
        button.addTarget(self, action: #selector(prevTrack), for: .touchUpInside)
        return button
    }()

    private lazy var nextButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "forward"), for: .normal)
        button.addTarget(self, action: #selector(nextTrack), for: .touchUpInside)
        return button
    }()
    
    private var currentTrackIndex: Int = 0 {
        didSet {
            guard playlist.indices.contains(currentTrackIndex) else {
                return
            }
            let track = playlist[currentTrackIndex]
            trackLabel.text = track.title
            artistLabel.text = track.artist
        }
    }
    
    private lazy var pauseButton: UIButton = {
        let pauseButton = UIButton()
        pauseButton.addTarget(self, action: #selector(pausePlaying), for: .touchUpInside)
        pauseButton.setImage(UIImage(systemName: "play.square.fill"), for: .normal)
        pauseButton.isHidden = true
        return pauseButton
    }()
    
    private lazy var avControlsView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [previousButton,
                                                      playButton,
                                                      pauseButton,
                                                      stopButton,
                                                      nextButton])
        stackView.axis = .horizontal
        stackView.spacing = 28
        return stackView
    }()

    private let trackLabel: UILabel = {
        let trackLabel = UILabel()
        trackLabel.font = .systemFont(ofSize: 17, weight: .bold)
        trackLabel.textAlignment = .center
        trackLabel.textColor = .label
        return trackLabel
    }()

    private let artistLabel: UILabel = {
        let artistLabel = UILabel()
        artistLabel.font = .systemFont(ofSize: 15)
        artistLabel.textAlignment = .center
        artistLabel.textColor = .secondaryLabel
       return artistLabel
    }()

    //MARK: - Init / Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        currentTrackIndex = 0
        
        loadTrack(number: currentTrackIndex)

    }

    //MARK: - Objc Methods:
    @objc private func startPlaying() {
        playTrack()
    }

    @objc private func stopPlaying() {
        if player.isPlaying {
            togglePlayPause()
        }
        
        player.stop()
        player.currentTime = 0
    }

    @objc private func pausePlaying() {
        guard player.isPlaying else {
            return
        }

        player.pause()
        togglePlayPause()
    }

    @objc private func prevTrack() {
        switchTrack(.previous)
    }

    @objc private func nextTrack() {
        switchTrack(.next)
    }

    @objc private func playTrack(togglingButtonState shouldToggleButtonState: Bool = true) {
        guard !player.isPlaying else {
            return
        }
        
        player.play()
        if shouldToggleButtonState {
            togglePlayPause()
        }
    }
    
    // MARK: - Methods:
    private func switchTrack(_ direction: TrackSwitchDirection, looping: Bool = true, toggling: Bool = true) {
        var shouldPlay = true
        
        stopPlaying()
        
        currentTrackIndex = direction == .next ? currentTrackIndex + 1 : currentTrackIndex - 1
        
        if !playlist.indices.contains(currentTrackIndex) {
            if !looping {
                shouldPlay = false
            }
            currentTrackIndex = (direction == .next ? playlist.indices.first : playlist.indices.last) ?? 0
        }
        loadTrack(number: currentTrackIndex)
        
        if shouldPlay {
            playTrack(togglingButtonState: toggling)
        }
    }

    private func setupUI() {
        view.backgroundColor = .white
        
        [avControlsView, trackLabel, artistLabel].forEach { view.addSubview($0) }
        [avControlsView, trackLabel, artistLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        [playButton, pauseButton, stopButton].forEach {
            $0.snp.makeConstraints {
                $0.height.width.equalTo(44)
            }
        }
        
        trackLabel.snp.makeConstraints {
            $0.bottom.equalTo(avControlsView.snp.top).inset(-20)
            $0.leading.trailing.equalToSuperview()
        }
        
        artistLabel.snp.makeConstraints {
            $0.bottom.equalTo(trackLabel.snp.top).inset(-8)
            $0.leading.trailing.equalToSuperview()
        }
        
        avControlsView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
    private func togglePlayPause() {
        playButton.isHidden.toggle()
        pauseButton.isHidden.toggle()
    }

    private func loadTrack(number index: Int) {
        guard playlist.indices.contains(index) else {
            return
        }

        let audioTrack = playlist[index]

        do {
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: audioTrack.filename,
                                                                                              ofType: audioTrack.filetype.rawValue) ?? ""))
            player.delegate = self
            player.prepareToPlay()
        } catch {
            print(error)
        }
    }
}

    // MARK: - AVAudioPlayerDelegate
extension PlayerViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        switchTrack(.next, looping: false, toggling: false)
    }
}
