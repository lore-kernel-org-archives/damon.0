Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86597EEA9
	for <damon@lists.linux.dev>; Mon, 24 Feb 2025 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427622; cv=none; b=oZynwJnUrTvAOwROBK4MA+5ZEPNNX4H7Hp0DgUuf1rKEUYeZlpfKOwvpP7MCmvwaxlGWWBtn+vrQkgB4vcwooESOJq9fcZLIMkOWC0ZqlRlUEz+NL2hotLjhwT0zO66A35O2TuL2NZQhgfOT/6dKN4ioff/Ea1FmFWq7ChPLFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427622; c=relaxed/simple;
	bh=OsaFSS+9RcDwfqu9EkxEKHCUiyyFt5FkEPOTsFbrf58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Js8GIX2qC10HF+iHRrHWg3PYia5YClvyC4Iwn3avLkwFxBHyju1Pq4xVgwr8PpBSz5QbLxAfGoyN41LWemvT52lG5gKWRHG7y9/g+CCuHuExwkMgzD3fxB2/g+OhF4X21Nib5n1D8DIwPPH8o6fnQ2eyyndzGlYBd+gORWHGgws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsfQoW8W; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsfQoW8W"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21c2f1b610dso142120505ad.0
        for <damon@lists.linux.dev>; Mon, 24 Feb 2025 12:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740427620; x=1741032420; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpxgQh2/vzDzfg5l48awf/mNUr75KmbIE1zHq/QyGps=;
        b=CsfQoW8W4SPM5iRwaSnIAxZT3A9L4hL+Jlm76dnR21QS9hTcPUNwQvdkL0AYknCvlY
         grIkiwPOZ8UmMQyvNt5Xw4yH8lhKJ701n/S5W9wHfU41OP383izzpyaOnebb50OmRUsO
         2JJKMn65YRSlA+IrafzLTUuOfZ8wl8FrbYHAdzzIXEitwYylvw261RV7BBuzo4leGzOy
         J7ikaAGVEovLvVnuKxwLaSMwZuIpDUxM2zoLL2JbZfHyRF1nZWi0nBwZsgZCnqAlYdFR
         amLfMwCYz5b9uHn7R+kUXOauPSeVOlEa+vkWF7k0N94FnlIJXdiSj8Oq7Z4JmqbmPcFR
         EpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740427620; x=1741032420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpxgQh2/vzDzfg5l48awf/mNUr75KmbIE1zHq/QyGps=;
        b=rIOERXUmRHDEQxHMxGomet7h1m5phfEd66DNf150tDZ7l0aCHJkuU8p0GXKW0HvMlO
         HKnkIWWPy6c2ARn9SJOnG5dImuPJ4q25bhxJ8pVw5t9jTqfTX46zzTqGbG0Tmuu52Xz4
         R4fxqzLjyFsCHJ2KhSEKCoWlX0sJn6jCSzgyZ4z9nFMWLq89mvAbzLdb7feKuoMmU3Tg
         cEBo1ZU6ToDiHy9R/yoPXPeyyZ9daniYfh58k7jU+GlHcJjZVWNg1p5V81/L4VowsL8M
         LHUAgi/ugAnfy13jNt3p2yPqyj6dCt5LH+hH2X2rf0hXDdRIZcucMqfPC4xfF4ENdm4r
         2dSg==
X-Gm-Message-State: AOJu0YyIWXvb4ulIKlBM7heQSR1biKIhFB7cm3L+VA7KBKuVXKFqcW3E
	gK/EeznQul18SIe9Rvzp2G+c4XsLX3LW60MQk99le0MqZbWteD8HEuAAPw==
X-Gm-Gg: ASbGncvWmeGpmbvOPS9Gnz/XwzxOiZKJpddfUDmw7LYe2RnaXuONpVUM1RvoCgk5TJk
	rG1bIdtMT2lzimj0YmFyKMc7PzmSNdpbKJrAY4N8vjD4eTbbJaSNFkO73EozL7p09Xd/yj7cNi5
	n0ROPAFgttCr1cmbE31ob2yWquObPCJLq5C+RPZo06gsWfI2hfzZg12CnlUuLF0BEg8KcYgL7p9
	wk6SvRJIFsMTJXlKtPCm6dNwX39Exs8RW0J+JbWCCRUEnKjH/4g7kh+Cdd/WcKyeNoolOPigWdc
	FHVicje7d1huUhYXB4uCjVbnenxcACI+sdheIAQfb1wo5uxlIxx1EK22ruZBfseqy/ocEGs/4A=
	=
X-Google-Smtp-Source: AGHT+IHiYDykHetQAEtFco7WYTZuEQw5/DtJ7sBqWLzDCoO36/MKMjZyaB2t+cenIfus1ySIK6w1pw==
X-Received: by 2002:a05:6a21:348b:b0:1f0:e512:6041 with SMTP id adf61e73a8af0-1f0fc778d22mr746630637.27.1740427620172;
        Mon, 24 Feb 2025 12:07:00 -0800 (PST)
Received: from localhost.localdomain (syn-075-080-158-112.res.spectrum.com. [75.80.158.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a72eee9sm41136b3a.74.2025.02.24.12.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 12:06:59 -0800 (PST)
From: bus710 <bus710@gmail.com>
To: damon@lists.linux.dev
Cc: bus710 <bus710@gmail.com>
Subject: [PATCH] samples/damon: a typo in the kconfig - sameple
Date: Mon, 24 Feb 2025 12:06:55 -0800
Message-ID: <20250224200655.2254536-1-bus710@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250224190145.24272-1-sj@kernel.org>
References: <20250224190145.24272-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SeongJae Park, 

I found a trivial typo in the Kconfig file of the damon sample module
while I was trying to do some experiments with sample codes.
The word "sameple" should be "sample", I believe. 
Please find the diff below.

Since the title should follow the format of the project, I sent a new
email to the mailing list. Sorry for the inconvenience.

Thanks for the interesting project! DAMON will be very useful for many
projects.

Thanks,

Ps: I found I didn't change the subject! Sorry this is my very first
communication with the project.

Ps2: I see. It should go over my signature. Good to know for
future.

Signed-off-by: bus710 <bus710@gmail.com>

---

 samples/damon/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
index 63f6dcd71daa..564c49ed69a2 100644
--- a/samples/damon/Kconfig
+++ b/samples/damon/Kconfig
@@ -3,7 +3,7 @@
 menu "DAMON Samples"
 
 config SAMPLE_DAMON_WSSE
-	bool "DAMON sameple module for working set size estimation"
+	bool "DAMON sample module for working set size estimation"
 	depends on DAMON && DAMON_VADDR
 	help
 	  This builds DAMON sample module for working set size estimation.
@@ -15,7 +15,7 @@ config SAMPLE_DAMON_WSSE
 	  If unsure, say N.
 
 config SAMPLE_DAMON_PRCL
-	bool "DAMON sameple module for access-aware proactive reclamation"
+	bool "DAMON sample module for access-aware proactive reclamation"
 	depends on DAMON && DAMON_VADDR
 	help
 	  This builds DAMON sample module for access-aware proactive
-- 
2.47.2

