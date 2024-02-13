Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186DC63110
	for <damon@lists.linux.dev>; Tue, 13 Feb 2024 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864421; cv=none; b=eCLX9RyYEE/udL3l97IsaqKm6ZPE1k5UwE2A6YfJLuWyf/PEhd8DLYx1vW8CjHXhETrI/JEzU2qRybMijAql08VzJbuhpL3S6kE3aBDayGrD05RjRo4Dqtwg11wttCPs80IvbU20+DlaCCfk5z46BQajznEMi8xtwQaELNPCE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864421; c=relaxed/simple;
	bh=79sVC2xwZcWf9em7+im8l8pxbyWTZViteqZQC3s1w5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q2f5fZp306be/h4lu0dtFa0XDj/QQJJ56dxCMFoyAVA0OHplUvWpt8qvrczcWk/TfcIB6tx5xTKxsiVIoTE7xrAxzgwrFGNAIfNrdtqSFgimIIZnDJ02wcHinTMQb+D/e+/7KJPj2onHAPDcBr7AP/qO5uLE8kpZwqlM01pNOdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvhFozBz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvhFozBz"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5620c778052so1243913a12.0
        for <damon@lists.linux.dev>; Tue, 13 Feb 2024 14:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707864418; x=1708469218; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPG8iWh4xmglJXdCUV2hXb98YGfDYIZwCuRxjUIHlFc=;
        b=HvhFozBztl3hpfPmGVBnymu1mTOoxHADlh1JItfhOrGxjGa1m+tgfCtwNXW2GN67QF
         awBVC0KVLOUUnUJCTktFG29dWqcwksXKcQNVOTDovvJWlF23Y6WNNdWUHcCOGfDMFN6c
         zA7gzN/qccxLmXTj1Ul9Qv9n6uaqznnOE7rQmaxLs4UlNvymMeBQjovAxg5EfcRwWAN3
         iUErIJ0Vhk+MjB96hymda2/uS0jXhxBzodEgyT+mx80Em0l2V3ZPxD3swFD5BzxzFDhM
         g27BHSFi/Q8ydk5oMe2fomOW40V+6vQqnUzQIHEY44X/HkoRJ+7D1H6H7KXIw0bFerSq
         OseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864418; x=1708469218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPG8iWh4xmglJXdCUV2hXb98YGfDYIZwCuRxjUIHlFc=;
        b=Vm+QCm8/mq4F+K/n5qt2Ml+Q6vZCumhvnEDuIgt2SZQ7WaTrveJOup/HwBqmaWO8AA
         qiS1i2wROyjjapEI8jLaOQbQ5yuZ4chXOA+gkhBac5gJJfc3nMvk2l/elTWzFGC/wfpK
         cxvhV4punPMGpqcC2zaLO+AImZ8HlKD/6qvlVOrTvUfpYnvMB0Mj6FqITqTxF+dakTQ2
         HZy+me8l6DVk45V/GjSrjuW7+uihXKCDYUEoQnV9pNKYXI4BU8kqfZ39KBVeJ6WaGyXs
         92FIJTT4IhkN3Iy6DAYb7m+3Lh5RX9hVH/jtaN2KSdGHYfPFVZTvuroU7ClJYOTKxhZ2
         u5Dg==
X-Forwarded-Encrypted: i=1; AJvYcCV/IMebxvkSKTwwSH9gjvZrGL3OVIhPiKaZUY9gyIp4hEoQHSnNzJKyEzVDPoLZMtSyxcGXhndUzNyvIh5kBeJcopaOc30=
X-Gm-Message-State: AOJu0Ywaob3bxKdIOTi9kC500W/vAovjh1toS3vIvNb9iNiLmoD62cXl
	qndjAwbKHtKfz7yLsAy/uVri1cVGtj70n6wuhbp+e4GuPGloegfY
X-Google-Smtp-Source: AGHT+IGXiOrzqlpXBA+LtH3COe62AS9Q/cecLumpGLO9H0eR0Hz99/rWvxobh7sl5zAkl3fv9XSilQ==
X-Received: by 2002:a17:906:f158:b0:a3d:1458:5e58 with SMTP id gw24-20020a170906f15800b00a3d14585e58mr456500ejb.46.1707864418399;
        Tue, 13 Feb 2024 14:46:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLZJNZpLWzk+pfh/liSwNPjMprY7Fr+uyOu5A8HW/YQ1k9kI0OOPUcoiw0XHxrNKTF5gi51BoqpYFSokyWV8d8qHFpOXDlNz34RnGloWjFfN4AhoHCGcKSNWC0l2mq1g+5z7jAvEXWI3/8Y/aYYLyDIdl8W2uq8g6Of9jqm6tWr8ZA/9EL3bKTm56UZnzzutUDKqAXTst1wuh/6kV6EMCdkFSAPLcW/eGmFpWYZ6ppFPe3h3a6GmGOTa46Nsl9McgvgmY4
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6ae3-bc23-bc27-2247.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6ae3:bc23:bc27:2247])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709062b5100b00a3cd41b3c19sm1700077ejg.199.2024.02.13.14.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:46:58 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 13 Feb 2024 23:46:52 +0100
Subject: [PATCH v3 3/4] selftests: thermal: intel: workload_hint: add
 missing gitignore
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-selftest_gitignore-v3-3-1f812368702b@gmail.com>
References: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
In-Reply-To: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707864411; l=762;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=79sVC2xwZcWf9em7+im8l8pxbyWTZViteqZQC3s1w5c=;
 b=rxVm0HCSYW0Mmc5c3paZJG4pRTvet2GvlViV0bYprApnV++3xoyxHgO3PdRK/jpj3ep2zXhdO
 oiSwRnhrlZWCjOWSn10NugDSeKIiB4PVLdmB9GHTVZM9IOJXj/oJyVp
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The 'workload_hint_test' test generates an object with the same name,
but there is no .gitignore file in the directory to add the object as
stated in the selftest documentation.

Add the missing .gitignore file and include 'workload_hint_test'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/thermal/intel/workload_hint/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/thermal/intel/workload_hint/.gitignore b/tools/testing/selftests/thermal/intel/workload_hint/.gitignore
new file mode 100644
index 000000000000..d697b034a3a8
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/workload_hint/.gitignore
@@ -0,0 +1 @@
+workload_hint_test

-- 
2.40.1

