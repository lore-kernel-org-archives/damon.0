Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1248790
	for <damon@lists.linux.dev>; Mon, 12 Feb 2024 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767025; cv=none; b=riXbwWOUO4ynyoexB0DhQ25yfeAq+Xz3Lu7FE2637w+kQVI+MlhppGorzD0kTWa2j6WssbyGpSsHUgXDmZHeC65SZyCFsdb71Nu3NzMdurXhGRVpMC/VInFfl7FdViRwgBqwtBgkPhApms06Mz8OCYx6lyLKtPnP/yBIF/LNq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767025; c=relaxed/simple;
	bh=79sVC2xwZcWf9em7+im8l8pxbyWTZViteqZQC3s1w5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q5dzHr0qwHmKBdvtTmHdvkQoh/CXZaAjerc6CXHA7vBjxy2gG+WUVHtrkm2glSFPjxV4w14WOuxJ+wkikicJs4EqlGA3hESKE5YKF9MdzTAyY1ktgdrOyneX/Wp5N2phPr8lseobScMyjKtromMaQ+AlYBCGLNMjDRxXBzmZQjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er9gy9Dk; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er9gy9Dk"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so484026066b.0
        for <damon@lists.linux.dev>; Mon, 12 Feb 2024 11:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707767022; x=1708371822; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPG8iWh4xmglJXdCUV2hXb98YGfDYIZwCuRxjUIHlFc=;
        b=er9gy9DkJp3lMD6nBSVYW1XisSnIhmnCdVN3raBXhMAd+0BOjQAMtIugDQDn1M0/fK
         AuGbR1C4P3nSbYBT3m3DJ8YgP3qIHBE7+AUaR2L4ncuYYT5wfaOSDi+Nkp9Co2n/kU6D
         YlQtioB6PAeGVh/gzCjftmwCtLjgMChY7YhwB6ZqWVEHPxqjAVo2PMZVXlp/EoBFy2G5
         OGj+FkaMpOW20mkFUhyFqJ0qNrUVxZehDGTrMKSc0GU/N6H0zTj2yWuVD8DSTf2R1YD4
         XsZzOfldif66jLQutI9HfoK3EKMc9wzebi7hnXsJ7rH2wDPeWbjG465nkvPrRltOuCCF
         5uTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707767022; x=1708371822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPG8iWh4xmglJXdCUV2hXb98YGfDYIZwCuRxjUIHlFc=;
        b=W2aYIo86ryu3DjODkc78iQHoWAryJ2xsVx1TZEP8YvoupgbbOc3+npGZuDoGxtaxuy
         v4E9E8g+HsSBcbW2fW+iJzxoHf4EY72cl1Fu4hDkaiJJZq5tMd+0cLWx1k9RiK/qKjcV
         ByrtmEbCwv5rarvfirvIxTXEydSr3XoyvOBWD3WFcSsWGWM8ohoHphgVMN5TO/BEmUIJ
         erRcNHn6knZwKvIm9tTPk9tU80IpJTm6HUPlj77GP3HHFS0M5jBtae26quCAf26IBJfj
         stY0/J3fueKYzSanpnwrfAhzRX63y8GInN8bfeOTsX9GKF8rnBVtTaNHDp+C9D23bpI/
         hPOg==
X-Forwarded-Encrypted: i=1; AJvYcCWSo6pzZT/wwWOgD2owPQIy1J4EIXCw4izJMg3HivALSxuKv0yUz/rIJUE7KjVrhGq5nHxo62SI9cpDFbfWLnM26NanY/A=
X-Gm-Message-State: AOJu0YysB0inddqsNzF0YWk9ZGHqKTfwSbUEtykIj+hSSrm8UsbSbgbw
	rwL/1/u2NZJ3bJ4JrD0TOH5H61QgUYBVbDn7CyOwq9XrSd18cjNH54nMp5u979Ud1g==
X-Google-Smtp-Source: AGHT+IGQ2Hlg20Ix6udElAAhia7/RYqGaB5W7gMyncHzPWZu9MivVdviuO0XtkfyYBLBr6dfK1jyuA==
X-Received: by 2002:a17:906:395a:b0:a37:bbe7:6002 with SMTP id g26-20020a170906395a00b00a37bbe76002mr4980042eje.19.1707767021712;
        Mon, 12 Feb 2024 11:43:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCd5I8WkWEB5eJ8OYq4fBxYWdA8Rsc5Og7yMBj6TTTCf1OuuFxQ2soRvncTE+4cbggtdeTjQ8nxAlBpR7cyihsReU/phIrdJnPPKDP0is0WE+FqLjB5lhWk1KZUKpL4YziQdymynbqPIklve16cpzXC+8I6Y+GnpofCQ6LCeeJA7EqAwud55ipVgQnvZeF/xVDhmIHAOgrRdNyON9zhdKIXzBdCdzbTEX0A4cBG+gnZA59wwgNGnXaFBxo500UjNXZ
Received: from [127.0.1.1] (2a02-8389-41cf-e200-8e14-1b8e-d285-8c63.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:8e14:1b8e:d285:8c63])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090699c700b00a3cb136aef0sm502323ejn.224.2024.02.12.11.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:43:41 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 12 Feb 2024 20:43:38 +0100
Subject: [PATCH v2 3/4] selftests: thermal: intel: workload_hint: add
 missing gitignore
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-selftest_gitignore-v2-3-75f0de50a178@gmail.com>
References: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
In-Reply-To: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707767016; l=762;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=79sVC2xwZcWf9em7+im8l8pxbyWTZViteqZQC3s1w5c=;
 b=g520wLOJGZZbI5OiA+HYqXQ6c0dqGB7oNt8TqHN6f3Avab9z+XsMtJS6mGmfLkivLIvsPO89I
 XcSpV6/A7xhCzTxrlRiq083v20G/kBDnve2MXn2pJI+eQ4keZkHisUB
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

