//
//  RecordViewController.swift
//  NavigationNET
//
//  Created by beshssg on 23.10.2021.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {
    
    //MARK: - UIProperties:
    private var recordingSession = AVAudioSession.sharedInstance()
    
    private var audioRecorder: AVAudioRecorder!
    
    private var player: AVAudioPlayer!
    
    private static let defaultButtonTitle = "Start recording"

    private lazy var recordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "record.circle"), for: .normal)
        button.setTitle(RecordViewController.defaultButtonTitle, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play.fill"), for: .normal)
        button.setTitle("Play recording", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.tintColor = .label
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.isHidden = true
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var avContainer: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [recordButton,
                                                playButton])
        sv.axis = .vertical
        sv.spacing = 10.0
        return sv
    }()

    private lazy var goToSettingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Перейти в настройки", for: .normal)
        button.addTarget(self, action: #selector(goToSettingsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
        label.text = "Отсутствуют разрешения на запись аудио"
        return label
    }()
    
    private lazy var settingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .secondaryLabel
        label.text = "Перейдите в настройки, чтобы предоставить разрешения"
        return label
    }()
    
    private lazy var noPermissionsView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [headerLabel,
                                                settingLabel,
                                                goToSettingsButton])
        sv.axis = .vertical
        sv.spacing = 10.0
        return sv
    }()

    private let audioFilename: URL = {
        let documentsPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = documentsPaths[0]
        let audioFilename = documentsDirectoryURL.appendingPathComponent("recording.m4a")
        return audioFilename
    }()

    // MARK: - Init / Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        handleRecordPermissionsRequest()
    }

    // MARK: - Actions methods:
    @objc private func recordButtonTapped(_ sender: UIButton) {
        if (audioRecorder == nil) {
            startRecording()
        } else {
            finishRecording(success: true)
        }

    }

    @objc private func playButtonTapped(_ sender: UIButton) {
        if player == nil {
            playRecording()
        } else {
            stopPlayback()
        }
    }

    @objc private func goToSettingsButtonTapped(_ sender: UIButton) {
        guard let url = URL(string:UIApplication.openSettingsURLString) else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let alert = UIAlertController(title: "Непредвиденная ошибка",
                                          message: "Невозможно перейти в настройки",
                                          preferredStyle: .actionSheet)
            
            self.present(alert, animated: true) { [weak self] in
                self?.goToSettingsButton.isHidden = true
            }
        }
    }

    // MARK: - UI methods:
    private func setupUI() {
        view.backgroundColor = .white
        
        [noPermissionsView, avContainer].forEach { view.addSubview($0) }
        
        [recordButton, playButton, avContainer, goToSettingsButton, noPermissionsView, headerLabel, settingLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func showNoPermissionsUI() {
        view.addSubview(noPermissionsView)
        
        noPermissionsView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func showRecordingUI() {
        view.addSubview(avContainer)
        
        avContainer.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - Player methods:
    private func playRecording() {
        do {
            player = try AVAudioPlayer(contentsOf: audioFilename)
            player.delegate = self
            player.play()

            playButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            playButton.setTitle("Stop playback", for: .normal)
        } catch {
            let alert = UIAlertController(title: "Невозможно проиграть файл", message: "", preferredStyle: .actionSheet)
            self.present(alert, animated: true) { [unowned self] in
                self.stopPlayback()
            }
        }
    }
    
    private func stopPlayback() {
        player.stop()
        player = nil

        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.setTitle("Play recording", for: .normal)
    }

    // MARK: - AVAudioRecorder methods:
    private func handleRecordPermissionsRequest() {
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.showRecordingUI()
                    } else {
                        self.showNoPermissionsUI()
                    }
                }
            }
        } catch {
            self.showNoPermissionsUI()
        }
    }
    
    private func startRecording() {
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            recordButton.setTitle("Stop recording", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    private func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            recordButton.setTitle("Re-record", for: .normal)
            playButton.isHidden = false
        } else {
            let alert = UIAlertController(title: "Не удалось записать аудио!", message: "", preferredStyle: .actionSheet)
            self.present(alert, animated: true) { [unowned self] in
                self.recordButton.setTitle(RecordViewController.defaultButtonTitle, for: .normal)
                playButton.isHidden = true
            }
        }
    }
}

    // MARK: - Delegate:
extension RecordViewController: AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(!flag) {
            finishRecording(success: flag)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopPlayback()
    }
}

