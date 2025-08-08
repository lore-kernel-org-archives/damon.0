Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB5E1A2872
	for <damon@lists.linux.dev>; Fri,  8 Aug 2025 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682941; cv=none; b=J2fg/++JpqAmxLZuzES2Jiy9J8sGUWXIC+GhHgbhUnNItvrPHkI0ARePfFrSbpPJJvtLc6rFGKnU/qy7aPVx5gZCnRGGw3wounAu+TpLy4C5mUIalzxmmS+3lDH0pNJDpsrJXA/AT4zzRSE7ZQ916LuXvepXReq3dI2urcHZPGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682941; c=relaxed/simple;
	bh=cMJY1yIHnE+SEO2yqUpcIpn54Y8+Fs7A44vrMelnAU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYMCgxkBZMjjFvy1ep84p9xL2fJ51fBJT+8FLqvlPtb0KrSYaNW8R/LynMB1DK6xI3S5nZbZF6KaarOGWIy2LmQEJOp8YOw7KgLq9N2y1gdLZXVvvVXIW5OEXf7W8SdIv+1XxfSAPkkXo3CvQIh5qjDh3BzRTRQRi4xNwdsVkr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/FCpHuj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/FCpHuj"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747e41d5469so2912174b3a.3
        for <damon@lists.linux.dev>; Fri, 08 Aug 2025 12:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754682938; x=1755287738; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eqB/Sho7SGdwhbbruKl9GuatUpYpgD51wl6c/nteI8g=;
        b=a/FCpHuj3ICDpTZYuwLkn/DZHme+wc4wCaqRE/Q7aYPOnJbl+DZAhPNihuUL4/pVDi
         Uk7Cgkf15ObJDO+SAGz15NFBUq+Hfxrf7xmKrKvqIkxWr+ZpjOFM5aCUunCRiliOY1fh
         03ViLOH4VOF63EpX9Mf9Ojznjw7VFJrUQZAEU9Kra4edavAXpF+Jdy3catB+xLQJsv/H
         3ICydnmBprzos0aRFfhEKQ0fiOfFiE/IK955NhcLaYU4hD81ph4OMiX65ifpaEgqgHzZ
         yoIM1cGhfwSat2Zy1Q4UxDS2AYcCeTNkr0WuukfFI9MkVqG03kTrcFAxGkIXJfJljZMg
         Ma5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754682938; x=1755287738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqB/Sho7SGdwhbbruKl9GuatUpYpgD51wl6c/nteI8g=;
        b=uG8Iiw1z282nEXNnAnuCbaYerpXfhusjA6PB4q8L84DbW870KbVwIlvMmncaM0V7DU
         uBEfx3GVSfn18Vfw+Xx9toSH3odSTlCn+ASiKOTbAlWGkxcK633gn7V3kSOBkhZXIgvB
         hrX+7M4FP7auw/9doCTOvtB1LiLznGo8ZbFw6m3/Si8GZalg92TL562skPRxycY3OWkZ
         0FR3spRqkeCAIep4Wj2lA4V2Nq3cUsSkVXhJl3mye3ITy+DNd8/g1Fe9v7ot5s5H2ReV
         WyiwTWiqW31vsT3iyKaYdeslKaIWsV6CbYj5wM5OZn1YpzfY2IAxxxdIivl8kiEJ1od3
         CyGQ==
X-Gm-Message-State: AOJu0Yy+T7flb2GEGjtxp6PR+E4ZaQz+6wlgwaAKIAm5kYSuu8SlF6pz
	a9v/J5dLDYP2C3f6uynQUvZbb14CD8Tt3Ic1v2HavNl8TyrEN0T15E8q
X-Gm-Gg: ASbGncvFazDUnmmatn/9tLW8BhkSYwdE3g6N5wc6SxFq6EARaHednsZyBYhNc2EUqbU
	vr7ll5DDUzE1szSt7YWz/I43jrgkwuJEPwxqIAgnoB0pwAnL+NPV3wXBOVmryfdRxExVAetk2cE
	HNbxDNw4M0K/quSHjURhhSAMadhxNXy2S6J7csOrppnZfvN1BXDSoBDat2VMUIBrRcKAzWOGLAP
	z4YnOsx47XXoHtwTPXB9/zKrlRQ8b0EPd1k6nii5BZafJWZbUQE0A/5kI/UCDz/f41QOArBxX6J
	XLe83JtZVibgNqI4MCdMw92RlQLee/EadeTVwPNJrs7Uqlj2zTFoB3j29ORdr9RpwEJ7Z1A7HlX
	caTgc+CWQXFarZ8zW
X-Google-Smtp-Source: AGHT+IHFozLerEyc686dk4nlDttJZ9Mww+TdFXINgSUY+cCWvU2o5P3PXK+Bi5fvRxn39KKF33gsuw==
X-Received: by 2002:a05:6a00:2e25:b0:76b:f73a:4463 with SMTP id d2e1a72fcca58-76c46193613mr6289492b3a.19.1754682938456;
        Fri, 08 Aug 2025 12:55:38 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f911sm21201103b3a.47.2025.08.08.12.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:55:38 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: sj@kernel.org,
	honggyu.kim@sk.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH 0/2] fix damos_commit_ops_filters iteration problem with
Date: Sat,  9 Aug 2025 04:55:16 +0900
Message-ID: <20250808195518.563053-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While studying, I found a section in damos_commit_ops_filters() that
looks like a bug. I first verified this issue through testing, and then
modified the code to fix problem. After applying these patch set, the
test which was added this time no longer fail.

---

Sang-Heon Jeon (2):
  selftests/damon: test no-op commit broke DAMON status
  mm/damon/core : fix commit_ops_filters by using correct nth function

 mm/damon/core.c                               | 14 +++-
 tools/testing/selftests/damon/Makefile        |  1 +
 .../damon/sysfs_no_op_commit_break.py         | 78 +++++++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/damon/sysfs_no_op_commit_break.py

-- 
2.43.0

