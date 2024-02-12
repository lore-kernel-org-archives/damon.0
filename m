Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348145BFC
	for <damon@lists.linux.dev>; Mon, 12 Feb 2024 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767021; cv=none; b=JgS5UFPVGkBcfP8vipLBqz/eiVTyMRakwpu2TC20q3mnhYZzqwbEsOYxEBWuy4QIbR1tjkllzMKnQ0wEGG3VZ/+Tecq7+jQ+qA14NiXiznOQBFnRMeF+lOVyGhIjBqRH3kNZxtXxfKLxRsIjfsNViLbTyK/Q6AM25gFdb/1NpuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767021; c=relaxed/simple;
	bh=T0sehhjp1xWfnMxeOoCLszKthu4iGg8Z5jE5Gow6vMo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Xn+Msa+uw7ZknLTe4tcB8lQUakrD7iK+/vZq7m2dSulnsa3cas5c3dJa7KJmnMXL3ExUMf+nbXvIvgXEjBiGFrqDTuLHqOO8LoOQzFZCdW/EG0ISQjca9w+fl5baa9trtUUB7RRaxID+OF+NrUOVcp0GPefRYZ0sT0XUFWmw++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/0yts9S; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/0yts9S"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56001b47285so263654a12.1
        for <damon@lists.linux.dev>; Mon, 12 Feb 2024 11:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707767017; x=1708371817; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3vo9bp4gTksdR64ewvsApQF1O1XOI2NpsvTDAM0jX0=;
        b=b/0yts9SicuyB0+JnCX36kEdMBHWE/lZWdJ9BBB4pcPhLLhfBK4LUjN4S/Ra4tMAes
         JMj6VsLPZzJzOujV1/RnJdX9gGLl89HnJPPW76Jt/E0vhVMrTdlzaC0cfBsEoGQ5e+nE
         315ZgVLRWwBz59mfthb8n7vOAkV7G+4rQgL/kScb0qsUNaPb5CvSlAOj0YNkfXDtLSeG
         mjsjfjLDJcTkJKxdXBAeFRMs/01nDvdKkfiwjNy+kqWozRYYYdhD4MimxNgBLvOOJ5Bk
         pvRbPAyXx2BErqc8Fq1ZNotC3B/b9fCf/NbWwdwEHYkQXKIArI5i6cbYgkwdNFJwbknv
         gyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707767017; x=1708371817;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3vo9bp4gTksdR64ewvsApQF1O1XOI2NpsvTDAM0jX0=;
        b=Q5PReuJLkdpvWqXkpO/uwLJnw8stsMccsJJxS5d0JCXPG8TmJ46ahgnu3EhKG60lm1
         uX1Ujc4esHvdmrzroEO8AFY9PjrD+RD93ylNfu5MlNEAshk6rJG1Fca4oZTJT9vC5FNf
         KtzxmOizalmWvy/xSlTzeWel+A4Dmvsn1YxAfGeYCdbu3VHwm1JDj00XIM5qhlAj/hnb
         fkcWOGUyEgNcwnLd+lr1yX1owt+w8igsXMlk+6oCSCSw009Agdet6TW1B7uhlXX1ufh6
         hdtWzal6LckEyJf3fVM/KTVsZgR+OtfyYt/qM8KPXhK2T93i9ryG+gRJOmtsjMRg9DPK
         uE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsFO/Ybks4EekY2MnvhET+bEB/Z8dqTTiInwk4jrD8753D2ie0J5AF1PaabllP0WOUWAKhueqnTUq/qXkh0FkxPipI6KA=
X-Gm-Message-State: AOJu0YzI3BUpnYyM5dDqUiLcojF054CfLaKU+q3CgWRouG8XBLMN+aur
	gra+7YqLGwsyP9FA7sgfwT8YZIBv6KTFYna1/NzQWmkTJxex62vZTuoJt3CMK4lpsw==
X-Google-Smtp-Source: AGHT+IE7yigdKLPrssuNF0+DK51FR9eDvN/BkekJpQ0YRHo4CDw2MhxBYxDAHbV0fBzl3QdlTPNydg==
X-Received: by 2002:a17:906:c318:b0:a3c:ee88:b600 with SMTP id s24-20020a170906c31800b00a3cee88b600mr358304ejz.47.1707767017591;
        Mon, 12 Feb 2024 11:43:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaPcNnEqSOx5xmBXr4oPJxnbdhaRcWotPyFCOGuyrisp6R8oDGY8nM7U1oZh9qbTRbpVdTKZgep3cnPEM213tAUpxX/vWhyvvbF1/Gen7glHRCh1Yxbd+XnAM+nb7cyqsolXHt/SCjvCIhYrxc7ZQlhwIizQG6SvLi2p4e2RqYYiRJN3iWZ7ce8nCwFWJES3bu+jX8rSeAvyeMoZvFplWRN+PqLsT/QD6I8ooJo7jH/EZ9B7l2BRehTqt9j4D4759K
Received: from [127.0.1.1] (2a02-8389-41cf-e200-8e14-1b8e-d285-8c63.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:8e14:1b8e:d285:8c63])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090699c700b00a3cb136aef0sm502323ejn.224.2024.02.12.11.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:43:37 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/4] selftests: add missing gitignore files and include
 generated objects
Date: Mon, 12 Feb 2024 20:43:35 +0100
Message-Id: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOd0ymUC/32N0QrCIBRAf2Xc5wy1tlFP/UeMUHfnLjgNtVEM/
 z3bB/R4DhzOBgkjYYJrs0HElRIFX0EeGjCz8hYZjZVBcnnmgguW0E0ZU35YymR9iMj6UUnT8lP
 fdQg11Coh01F5M9fUv5yr8hlxovd+ug+VZ0o5xM8+XsXP/n2sgnGGuhOaX9SoeXuziyJ3NGGBo
 ZTyBYK9TezJAAAA
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707767016; l=2076;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=T0sehhjp1xWfnMxeOoCLszKthu4iGg8Z5jE5Gow6vMo=;
 b=VI1nGBe+i3vNYwuDZEFPIb1hVKz6OMDvASuDHzixDrY9tuV3yfSZn2Em7pyH6ll9HFYsROH3d
 0GpiooV+liXDlVaNvEy+Ux8YTjm/JXAnilci/uX3VkTxiwefJIlR6Qw
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This series aims to keep the git status clean after building the
selftests by adding some missing .gitignore files and object inclusion
in existing .gitignore files. This is one of the requirements listed in
the selftests documentation for new tests, but it is not always followed
as desired.

After adding these .gitignore files and including the generated objects,
the working tree appears clean again.

The new version includes a missing entry fot the .gitignore in damon,
which was reported by Bernd Edlinger <bernd.edlinger@hotmail.de>, who
also proposed a patch for it as well as for other missing .gitignore
files covered by v1. Bernd has been added to the corresponding patch as
the reporter. If a different tag is desired, I am fine with it.

To: Shuah Khan <shuah@kernel.org>
To: SeongJae Park <sj@kernel.org>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: damon@lists.linux.dev
Cc: linux-mm@kvack.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Changes in v2:
- Remove patch for netfilter (not relevant anymore).
- Add patch for damon (missing binary in .gitignore).
- Link to v1: https://lore.kernel.org/r/20240101-selftest_gitignore-v1-0-eb61b09adb05@gmail.com

---
Javier Carrasco (4):
      selftests: uevent: add missing gitignore
      selftests: thermal: intel: power_floor: add missing gitignore
      selftests: thermal: intel: workload_hint: add missing gitignore
      selftests: damon: add access_memory to .gitignore

 tools/testing/selftests/damon/.gitignore                       | 1 +
 tools/testing/selftests/thermal/intel/power_floor/.gitignore   | 1 +
 tools/testing/selftests/thermal/intel/workload_hint/.gitignore | 1 +
 tools/testing/selftests/uevent/.gitignore                      | 1 +
 4 files changed, 4 insertions(+)
---
base-commit: 716f4aaa7b48a55c73d632d0657b35342b1fefd7
change-id: 20240101-selftest_gitignore-7da2c503766e

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

