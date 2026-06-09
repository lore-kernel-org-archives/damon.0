Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692333ADA7
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015684; cv=none; b=oxNZQPCgp+gW5EFo3DxAS2enl7p/BnZOH9SNtdq6bAMTr5f/mtqbS+1pKxSdXzktdiBSNWMwL8cOA2UjVCDRHI5wi+3xjDhdEy0tEK/GTl2C61zSK9awLkx4/i+Ogua1O98pIa9mWQ+NIWBG3ZWnhnaXJksV/QU4jfPjzzvnZO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015684; c=relaxed/simple;
	bh=OsTW4W33/dOPYebmwIgRMD90tqv9rvMiSMFARTYGp+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iw5kmaWeTvAhY3GQkGeIOTksgl6D7rySO//4wCTHi7UK+Vkyqjd/PZyutX1RPLQzR75FU2kateuFHTDYWU6d27x6L9yMLfroFde5e71iBD4eWLiRN6sD+32AZn+YH33dpYC5rBS9EJensbdu7ALlDe7PAaTChJGE3ADuciEGBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNAsVdvk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNAsVdvk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b1aefe1cso5968615e9.2
        for <damon@lists.linux.dev>; Tue, 09 Jun 2026 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781015681; x=1781620481; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+p2KLWGB60/y0hWSjB13j8Ag8QaYpZolde8d8AEva4=;
        b=CNAsVdvky/+3sxzWz3F9KOj5er1H+Qp7nk5lsrq56VLDxH8JbScNZw+GOKM86pzkJZ
         4YKfS3SWNOxZMJ1cgiV17OSkjOC7HimR/FH+nrd59vJ6KxzRBmasHb2YB1pSXiD7hZ65
         IPEqIsd8VM9bzcRjZBV+3E1UiSY0089YnfOMUvw5fV9ThlV9J5ie9fQfRc0h6pCJqJKb
         5T0u/p2xcUOi9TDcC7D6JBIU//4Kd5TCqKMWLibiBwKZbsv0gaOnPVCvVMtv9SmKNHea
         s2dGy67GoOnfimT9PuwdHBjBa1HHd3rORMK5M6LB/7tKP57Eu1fcf9npzFATk0A8xEwR
         gc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015681; x=1781620481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T+p2KLWGB60/y0hWSjB13j8Ag8QaYpZolde8d8AEva4=;
        b=r8bDxKPncpRm3oc84+bEEOREOZ05AU/1J7vdWNwwWPY6ZCjyBc7hjhhz2F5P7UhOrr
         iS0/s8CkNGJMl8HiS7ZvuOQtrtoSdvLRrFbY2DFUrPpNyIssemihY4pnh/00tHg8vAbf
         yOGg6IBo5nWY/IgUQZncCdZUctESHSNgl2tl+d2Sk9mNlyDmu9YYXSx28ACECeOIj/v3
         fIS+gQk8drmKkaHGB0cxcSrcJpLu+WNsjYgJBwBx5hJkGESVipFxWsC8n6PmhPxlFqsX
         I4uEmv2u+jJFU+XblQF8yuoJSExN1kKEEU1bqZJ39kKcwh2zXLPtVolvUb8GWv8MVZqn
         zYHA==
X-Forwarded-Encrypted: i=1; AFNElJ9rSXmp7Ac/708oznKIQ5mCjmjLEZQvtH7xlH8zUVpSewSbXpVb+ujJ5MmBAHViemGtfWbM5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPq98FlMqHxhBPDjLD7A7moD4Ym+f3rv+7M59Wpigf/00E9yVV
	U/dh+uRyzEaFeRYCZMrHOWZkR20l08DWzBW8lTtE5nWCNZq371G/YDLE
X-Gm-Gg: Acq92OHEqKY9/Vfav0gCQiuk4WeRf9GtFbr3riwMEJdOyl9F3gc+1/HLGrAv5N/PTeA
	R/GlZ4i61QMpSYhMobMGCUY8sU4VmyFrYpgiOXkug3r50B6YSdB7QX92cYhF6MgDH0JP9NRdtZX
	8IrS1cU8F9sR8ce853X2WN/kMI0MdGHMztAX4/IeCz9SPu5j6bcnnl1StjrdRWQFEDAiS2Np7Ph
	Mk4GRrBI7vKngJLuU77PWeeiEsW8kc3XnFMhe4nNRpCFafIrtu3tnLcoHBh52QoQlT39vuSfr6W
	L0kXc2qXcpCM23/8Dscml4x5L4hXK77COAgLeT2Ba9MN0TDoPRTWrjpNFJsmQDDO3D72meNXZqO
	ZX76t8tZgytzz2rT3VQOCEoBN+EE/AV0z+eb3ACxG0L4UeHZz6ar9S4+v4XC1H9DWWufDGebTgV
	rdqqLGpevS44u/AB7mvv+LpfMmjfYp56o1ieQW5ToP3XjsEwLrde5WRw4uy5C3FD1INQkVMonNR
	isbLj+iNFmDHCRDfqShH+ap4nTkVqSeOuawrA==
X-Received: by 2002:a05:600c:45d1:b0:490:6e0f:2a10 with SMTP id 5b1f17b1804b1-490c260ffafmr146105085e9.7.1781015681040;
        Tue, 09 Jun 2026 07:34:41 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm68670615f8f.5.2026.06.09.07.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:34:40 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Dongliang Mu <dzm91@hust.edu.cn>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	SeongJae Park <sj@kernel.org>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	Doehyun Baek <doehyunbaek@gmail.com>
Subject: [PATCH v4 0/2] docs/mm/damon: fix docs and update zh_CN
Date: Tue,  9 Jun 2026 14:34:24 +0000
Message-ID: <cover.1781015560.git.doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523094420.741003-1-doehyunbaek@gmail.com>
References: <20260523094420.741003-1-doehyunbaek@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First of all, thank you very much, Dongliang, for your time and
dedication in reviewing the previous versions.

This v4 sends the original English DAMON documentation fixes as the
first patch, and the Simplified Chinese translation update as the
second patch.

For zh_CN, I translated the current DAMON usage.rst paragraph by
paragraph, and added missing pieces such as stat.rst and the related
index/design references.  The zh_TW changes from earlier versions are
dropped from this series.

The translation text is paragraph-by-paragraph.  Some references cannot
point to the exact zh_CN design sections because zh_CN design.rst is still
behind the English design document.  I added selected translated design
sections/anchors needed by this series.  If requested, I will also update
the Chinese design.rst further.

Changes from v3:
- Split English documentation fixes into the first patch.
- Reworked zh_CN usage.rst as a paragraph-by-paragraph translation of
  the current English document.
- Added zh_CN stat.rst and related index/design references.
- Dropped the zh_TW translation patch from this series.

Tested with:
- make SPHINXDIRS='translations/zh_CN' htmldocs

Doehyun Baek (2):
  docs/mm/damon: fix DAMON documentation details
  docs/zh_CN: update DAMON documentation translation

 Documentation/admin-guide/mm/damon/usage.rst  |  12 +-
 Documentation/mm/damon/design.rst             |  12 +-
 .../zh_CN/admin-guide/mm/damon/index.rst      |   1 +
 .../zh_CN/admin-guide/mm/damon/stat.rst       |  80 +++
 .../zh_CN/admin-guide/mm/damon/usage.rst      | 541 ++++++++++++------
 .../translations/zh_CN/mm/damon/design.rst    | 145 ++++-
 6 files changed, 615 insertions(+), 176 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst

-- 
2.43.0

