Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB552E8DEA
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036706; cv=none; b=PP5+XXMAVxKeu2a+aStm0dmsFxlwXx16V5er1jGeYrHqzneJfY6QocHg2PQqBtj75lhVIv7wrjsuHCLJ+ToQNLWyF2yLJx4GHu++UkhGT+E1JmRlZ30jb4GJ1OeMqmDmW8027ag9SGii0mf+FUoRBS1hg0Rkx7L4nqP6Y1kEFP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036706; c=relaxed/simple;
	bh=hb11/nUQEsUITe15ptl7gaVSGBK9HGkxdnrQNIZngeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BDhYk32duwOuA2SuXfwJ7ZXpsPX+r2Q/HfMk9W4ynSsTibV5PRwD8V2hq4tsQHqPDk43elzNIEjA4A4lXUnag4aWkvTK7yZycyCPCGi+r2ei67sXc+XH1gdQcTG/d4ajdZPxSf7pxKCYfapJ1b5LqDHSU2winvcKeCo2BJOPCKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q95l7TbV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q95l7TbV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-499a5ca9292so93855e9.3
        for <damon@lists.linux.dev>; Tue, 18 Aug 2026 00:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787036703; x=1787641503; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jqcogyCGg70wu1Q5vb1IMYop9IyLUdmqSQiNTAzefnQ=;
        b=q95l7TbVtHDfqI4J99+TumvH81Z6bMw2BSRKBXnRrUTQNzxHMck4ZL2M+04l+IFmUa
         wCnfSfhITFj1povldzjoh5VF8yc2P49aMiqmpPw+BnSmKN5lFP6cEYc4niC81ttJFEvy
         ASWh2vrttjpXXg15d2eEKfktlEVGv5PHN/f7VRY3PSqAOlIhnCz8HKKyJbS9O0Du4Ju/
         UwKJNDT14gs4zVMKMZNZtVGxLZeKSDl0zkYvzD70xvaizFbN+ZtI0VGZZr+vBdO7O/rU
         gyiZpVvwvQEI/7Pnp0CJfr7WrcRZNwVrFIkD8yZExrL4BXPPNkbC3tDT3rL+bhd7Ygt3
         9SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787036703; x=1787641503;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jqcogyCGg70wu1Q5vb1IMYop9IyLUdmqSQiNTAzefnQ=;
        b=OBDDz7nLFN3lSp7SX2oX7FMUOvsOT0BUyjyT6FC+nSH2TPmXEc6W8fyXw7Z5k+cLF5
         yI+U/jhakV2NU3myhlvmusWVOUsjOPs5xKwpf4ek7/W59vAhOamRwDtqY8ovO4IME/R8
         zqyCTeKO4Y2C/kaxwfHY3ejKC8gPc/LYGLGgAfJY7iqJ2agw9r057v1DYENC3vOGukSe
         s3ivIJalZruOALSdSyGi3xb3qGX3S9P2bYeKYnke9g2eM2Z6i2sr0Ur+wbhlz7E81H2f
         Y2Mb+WYbFbEo7nLMo0hcPaWvPfb2lUNyEHQG9Ze4N0IJjXYMOT2aVTUCphWg6BqBy2cc
         92HA==
X-Forwarded-Encrypted: i=1; AHgh+Rrab94R3aBAiZZVGTng8M1UxprhWn7XvOrnnzO9PfGRKPUcmG3ymS0MbzxE3UBIFlMnPSbjUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiCj9y//rJ+ukg8DTn6uF9kjn8eLlzYdfx08O3PyKzAuPZoc5Q
	iDr1GFu4SLk/5q6yeFmoLhslW0xr+JM/hIxipM+A5EpaE7RaCba0wBFB
X-Gm-Gg: AR+sD13dNiVKGHSpWfJquQfgtNgQfirtG/Ncvu/CBH69fOlPSMuLYXMkGU1chZ9XUXt
	ZtHxckysxL5/kygzmuTafFkf3mfxcvCKxBwCYEZGyJrNrYtz3hu7eFiJ+vb5bb6ktxC50XFmDuc
	/042fIFZQKwfWUm7fdkDq3edRDxjU6ESCh4q8be+U4SO2r0e2tv8laRtKD1IUdnZVPjd2yvDC9r
	p5RgokLGnNSu9zY8Buh8UUJ9kW3H5aRSlliCgyny3eNycHaHeJRLejWRhn/HlcU1lmcNJNL9X98
	oCgsPnWQWlWinByseG1DLlS1v33a4YEc+eeTN0U2H5lKpEyp2cAr6oDO1NT87BDReHMKlMWs7eO
	/itKsRKzsVHUR0Pv97PNP0eEF9n878nz6D4JU/ajDD/mkfORb3sAnGBY1nnyS8sGu+52yULpfgC
	BN0A4ot/S8PAYxCVpBjH1TQFt2ZpDRA1dnYAbTqDn+n71QyUVijIa/KdKCtivQFelUfTxaRrnGI
	amFxjAhtIywvTDmfJyMy+tXq0jYjjnPMdpwmKh+dVsEaKnF2P8+fMBfR7UjMd+PmSUiH/p0vHIX
	PrHFxHpG14McZYGZ/QMscOO4lUm0HN0Ifl7FSXNoRM2QlfTMKDX9+u1v
X-Received: by 2002:a05:600c:8b57:b0:499:8411:9e8d with SMTP id 5b1f17b1804b1-499878cb099mr229907745e9.0.1787036702721;
        Tue, 18 Aug 2026 00:05:02 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996188217sm495557495e9.13.2026.08.18.00.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:05:02 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>
Cc: Doehyun Baek <doehyunbaek@gmail.com>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/7] docs/zh_CN: update DAMON documentation translation
Date: Tue, 18 Aug 2026 07:03:42 +0000
Message-ID: <20260818070358.455768-1-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bring the Chinese DAMON documentation translations up to date.  Update the
DAMON design and administration-guide translations, and add the DAMON_STAT
usage translation.

Changes from v7:
- Use the suggested translations for the DAMOS quota goal ``nid`` and
  ``path`` descriptions.
- Replace the remaining "聚合间隔" with the consistent term
  "聚集间隔".

Changes from v6:
- Clarify the DAMOS quota goal ``nid`` and ``path`` parameter descriptions.
- Improve the translation of "offload" and fix the duplicated character in
  the non-access-pattern filter description.
- Consistently translate "tracepoint" as "跟踪点" throughout the series.
- Consistently use "监测上下文" and "聚集间隔" for DAMON terms.

The changes were suggested and clarified by Dongliang Mu.

Doehyun Baek (7):
  docs/zh_CN: update DAMON design translation
  docs/zh_CN: add DAMON_STAT usage translation
  docs/zh_CN: update DAMON index translation
  docs/zh_CN: update DAMON start translation
  docs/zh_CN: update DAMON usage translation
  docs/zh_CN: update DAMON reclaim translation
  docs/zh_CN: update DAMON LRU sort translation

 .../zh_CN/admin-guide/mm/damon/index.rst      |  15 +-
 .../zh_CN/admin-guide/mm/damon/lru_sort.rst   |  68 +-
 .../zh_CN/admin-guide/mm/damon/reclaim.rst    |  82 ++-
 .../zh_CN/admin-guide/mm/damon/start.rst      |  63 +-
 .../zh_CN/admin-guide/mm/damon/stat.rst       |  94 +++
 .../zh_CN/admin-guide/mm/damon/usage.rst      | 523 +++++++++++---
 .../translations/zh_CN/mm/damon/design.rst    | 667 +++++++++++++++++-
 7 files changed, 1345 insertions(+), 167 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst


base-commit: db6ed2a3d31068ca5577466591b2521dee0508ca
-- 
2.43.0

