Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1792D6635
	for <damon@lists.linux.dev>; Tue, 12 Aug 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986371; cv=none; b=a3cLkJwLAqB8u5Ct+OTag0UIn+ZY0BfTtS3TNphF6jJNXzFYSnNaOLFQ0BeM7xnUmbPVQXbdDP1hWH4nQ0VDglfXhvQcUUXBlXPP82j6KBAxS0TRaPkesC4CTAcPihICviVSGPfhINKZt2mwvW4lKEX+hGINZw7UUQHuPWaJODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986371; c=relaxed/simple;
	bh=CygRsQzHeViey1sMjJDwpFXY4aVKiZK+tOw7A+FX4l8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MIZ1QZ/3c5ZDN3gYVUxswubZra0YzrQWISejaNo+zK5jH9BCVnqWi/Z+TvzmHOHD4+jr5ilrhCWuS+LhfrUCxRZ9x/jgwMFLnxzBtW59oKUl/7sIM6jdzxp+qXLqtFHvrdtbISJmPTwHZo3+qSJqQVo3dzpTQ5zrQk7egT6GovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Qci+in5+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Qci+in5+"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76bd7676e60so4417126b3a.0
        for <damon@lists.linux.dev>; Tue, 12 Aug 2025 01:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754986368; x=1755591168; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yw0gy+knuGeGzY6jivnMfN7pV1rj29Xt61Zw/czzFhY=;
        b=Qci+in5+b3tYuUHUESkw9q2Rk1xUcGSef19pu2QzH0YvvXRvvIR7VoqAdiMULElkE6
         Eb8DwseFRzhQ5eKSxVRWeSoXsMo7IO32Yked419aE1zPpI7yO3YCiOb5nffsPvzkn5Nz
         67PquCl1qvfMJXHHzxr6DUSMDYw1GA2XXE6KZCefKoAFLQ3mN6J3O0QdS8Y1MC2/AYtF
         Y/anCrLe5fkhUZJQ5yM175SJLHAEQnoUuEnLC0jBx+eicNTBbQUSpaEWnWISziX4AlSX
         XT6q6i7oNWVoGbSjVVf1tQ7IgusJFU64GFVa7e8LKBdydTgCyPEWD5xerzd1rscB8UCG
         w05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754986368; x=1755591168;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yw0gy+knuGeGzY6jivnMfN7pV1rj29Xt61Zw/czzFhY=;
        b=vQTSus84iBe+oCo7jC0iBGDtX1NJqSvJlpCg07rbs/i8QMW/itfnNmF2LbWDCcqT72
         AnGvvaxC0CkxdEhzmCf9mrW4VC9oYLThWdpjkW8r6vE000sFgB6i6ZtJgwZvDLf9yzVs
         fIQ0IZ0gRSlTOFCRCcW2KX0Bwwk6WLZaJR9tQ1fH5/455l4dWsAf5sFmaaoYcl0TfwCz
         Eb9l8icElFnO28se5oq2v4MsjV3DKE6GoEW8rATdOmCVz8SwKxvTg7XnR1+P2EpwEjk4
         jdiMzHb4G+VcUfDLllm3paAFmxEY/XUzdDjeTxmVUkHFMayUj0j/HQQpC8ZsmtoqJriw
         8flQ==
X-Gm-Message-State: AOJu0YxjDmTWTCaX1Ze5FZFlz65SY0q4t9RvueBa8CpsPhAdlKlWkkry
	XUbGXQS32Bj0xxf+RxuRV0AhjxEr41i5G9KvdPCo0qbnM/o6kvwPxoJdmMDUX4ySm3M=
X-Gm-Gg: ASbGnctsC3q23vP/+MRUTwVb/Zkoe20+oylqFxD4jGJEkMTbYkJmtKHXHiKALA0KkM5
	x/MEwTsFbhFA5Vau35/JI4vrNLFYaVPtL1WWhAK8E0o2mQ3eI1CK0afxKRgUz6/G+Oyh9FT7JX9
	nhhFdMjzNMiQGemaHfE/rpYrTXpXPn8Q0q/K1K3JMHu7/I+WCkr434uqMsWZh4v0Q60QLDHsho2
	i1B5BXWXB8DGPFyJ30GjAN641dx/PzQTBD8230MeopcIkAkr+b13XFuQF2f8A5zFevt5aeDb9WL
	lTvl/vwMd3wrYjDykMc7yD6RBJNnsFrDJVz2plvQrYQF0J8rzUz0R7hB8LzX6uHX477hYERg0qS
	N7aqxHXtj/XSB0bBrYbKuhT3ynNGY9QCse4OPcCdpviotI2rTGhPAJkR293CKjymJMx5Kdg==
X-Google-Smtp-Source: AGHT+IGv0knKdRcpuo+yhVFvI7xkp6TkQ4XGBRBCTHxnRsgbNXwPcNcWPjfrvDLzGLuhSytlCrPZuQ==
X-Received: by 2002:a17:903:247:b0:240:3c0e:e8c3 with SMTP id d9443c01a7336-242c228e6femr208574645ad.51.1754986368009;
        Tue, 12 Aug 2025 01:12:48 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e83esm291171955ad.49.2025.08.12.01.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:12:47 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 12 Aug 2025 08:12:11 +0000
Subject: [PATCH] selftests/damon: fix damon selftests by installing
 _common.sh
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-alex-fixes_manual-v1-1-c4e99b1f80e4@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAFr3mmgC/x3L4QpAMBSG4VvR+W3FlsitSDrZN04x2iK13Lvl5
 9PbmygiCCL1RaKAW6IcPqMuC5pX9guU2GzSlW6qrtaKNzzKyYM47ewv3hTDGri2sbYzlL8z4O9
 5G8b3/QDygZf4YwAAAA==
X-Change-ID: 20250812-alex-fixes_manual-aed3ef75dd83
To: SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Enze Li <lienze@kylinos.cn>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=CygRsQzHeViey1sMjJDwpFXY4aVKiZK+tOw7A+FX4l8=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDJmfS9tPHdv2e/gSPnDbX98/P6y8smEhomFZkvN8NSNf
 JzmepKxo5SFQYyDQVZMkUXBPKGrxf5s/ew/l97DzGFlAhnCwMUpABMx2c7IcKJKMfDZyu7SW6eu
 i6sb2R6bxmCePlXJaktytu0G9uKKlYwM129NC3i4x4knS9vwc62dnPXFhi07dT7cYTz3Q6epca8
 aIwA=
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3

_common.sh was recently introduced but is not installed and then
triggers an error when trying to run the damon selftests:

selftests: damon: sysfs.sh
./sysfs.sh: line 4: _common.sh: No such file or directory

Install this file to avoid this error.

Fixes: 511914506d19 ("selftests/damon: introduce _common.sh to host shared function")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 tools/testing/selftests/damon/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
index 5b230deb19e8ee6cee56eb8f18c35e12f331e8b7..ddc69e8bde2905ff1c461a08f2ad008e6b28ac87 100644
--- a/tools/testing/selftests/damon/Makefile
+++ b/tools/testing/selftests/damon/Makefile
@@ -4,6 +4,7 @@
 TEST_GEN_FILES += access_memory access_memory_even
 
 TEST_FILES = _damon_sysfs.py
+TEST_FILES += _common.sh
 
 # functionality tests
 TEST_PROGS += sysfs.sh

---
base-commit: 2754d549af31f8f029f02d02cd8e574676229b3d
change-id: 20250812-alex-fixes_manual-aed3ef75dd83

Best regards,
-- 
Alexandre Ghiti <alexghiti@rivosinc.com>

