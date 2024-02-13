Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8D863104
	for <damon@lists.linux.dev>; Tue, 13 Feb 2024 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864421; cv=none; b=Abgk9pT0IL+Axz8IAQDq6qFzfHNeIM3N1F96/v5BmfN8zTnkJBcfremaPvjXE8Yu74vYdPwBTSrRfcoAyqJNdRuqxaRE8QEtDvxNkn5xisvoLdgRDPou6E+NruA+Omr1hhO9tTxz3ZRhX5iqzn1XFreec4IHz30REx7w/vJiS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864421; c=relaxed/simple;
	bh=WtHVq1MaM2xClIr1rMsfIROFbVO+f54SK2iXyPjvLXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnug/xic5dj7tNERi+e9YkOH+yWCdl93pkqIfg5II2J2kkGoh28qX8+1fFRym6fOofNHvqeeXOvIrJ1uKae3JWBOCIAQwuWWTkzJEt9z1OZc+nLk0yr6LVYCm3W3sK8lFJTRUzq/dqGQOWeBrlzAuTEHNqWwasj+scPUXTwXXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUaUCTSd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUaUCTSd"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3d2cce1126so57642366b.2
        for <damon@lists.linux.dev>; Tue, 13 Feb 2024 14:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707864416; x=1708469216; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aW4knlrv1UA9D61zJujTvwkGENLspNvcPvyx+chnplU=;
        b=CUaUCTSdwn5fA1uD8ZiiufUQAglfcICkMyCfDtAnqWN0YGFtiSk6K+/NzcXi35AqGF
         moHYltzlRQRZkuKmmXU62SoLljqL/AyufyXS8nm7JXWphp86fVGnHqtWENIj4ljq+YaF
         XwBORmZn289grmgHFtlgA3H3I0m6XG42oz9+fGJE5V+eloaL/W1uew9VCYfacUVmCATh
         FilBMGMFXvPOBU6obCECXEMAWVDbuNhB3IUfVu3BPWOVvmKh1SeU6HBCoaGWsQ9mWJHP
         rhm0DlIVq9YeD2dkeYBciei0Pr1bTWtETs7xC6X7d/L7va2yAyjSC/EMxwwllYg0j7I9
         brxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864416; x=1708469216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aW4knlrv1UA9D61zJujTvwkGENLspNvcPvyx+chnplU=;
        b=jz3hkI534UkBPlWTZnQgqijCB7Sb+nfBnKJdj86PDAOU+nJellLVpOhfglZWrIL9CB
         dXg+5353tC5xJgs7Y+xoSxQ546kGNC+CfQYYNBf1PRqE9Ei61AXtTZpV3gMSiiX99MJg
         GZLW2qR4Pbct7NT6qJIbUwMSEtz/QE2A3UJP9ZwqVID4578DPY/k+0RoizlQ96cmjqDV
         kzm8mq95zIefjPVCYMjdruIYDuCs2mRhj78PXhCgsEo4pGJWzygEoStrcYRvzW3aqZEj
         JLV87OyPragfAD7t9XrfNkvZ0h0mBtrzqNELZlwrYDZxg2rx79InqRq2y96iIu7hY/Gm
         tOJw==
X-Forwarded-Encrypted: i=1; AJvYcCXTiNSeUBeDUFDqZ+7KYGPptuAaksgN4PkCSAAKOuh6fIxiLGCE22Slea7Z7UjuGyafnXDMMn3kPWsaNVWlhj4lxiTtcmo=
X-Gm-Message-State: AOJu0YwG4aFmY4GLbKAKWNuXpkMrDa4B3y3/jMXpNo73Ju/f0eJUEuBU
	z1Cg0vncco/IoqkWzlEXOS5i6rDiegNtw65yD7+O8t88wYrwLgxP
X-Google-Smtp-Source: AGHT+IGDjbSTZVGf6XhPhYYRobLIqjM5KZUMdFhaPnLuHPwzJ+FOpG+mlFwMNBRZNk+Ge4z3+liMaw==
X-Received: by 2002:a17:906:688d:b0:a3d:2406:7bb1 with SMTP id n13-20020a170906688d00b00a3d24067bb1mr435101ejr.39.1707864415721;
        Tue, 13 Feb 2024 14:46:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGbZvO09HFGDdXMwinSY0I2O7u4l5/GFpE8z8Gibi24oPw+o4BEYbTKS5GmBCIrWSfLQyePDgBdl65J5iRpzuesUDL6QM5PzO3xmpcq61Hq+1Zn8cLFkYfuIoxLnizKs6ADSixycoFL72c1cScI8kRlT2cW7vdkQVQZpS8U/7mw+siZEzehdN8/OyMYmU4fDFkoCG6jBBM2L6uo0+IekM9bea2wugmuXo7FcCMDJxySqsoJWPDBUbRKnN0Y7CIkPG/TWIr
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6ae3-bc23-bc27-2247.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6ae3:bc23:bc27:2247])
        by smtp.gmail.com with ESMTPSA id b17-20020a1709062b5100b00a3cd41b3c19sm1700077ejg.199.2024.02.13.14.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 14:46:54 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 13 Feb 2024 23:46:50 +0100
Subject: [PATCH v3 1/4] selftests: uevent: add missing gitignore
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-selftest_gitignore-v3-1-1f812368702b@gmail.com>
References: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
In-Reply-To: <20240213-selftest_gitignore-v3-0-1f812368702b@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707864411; l=672;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=WtHVq1MaM2xClIr1rMsfIROFbVO+f54SK2iXyPjvLXA=;
 b=eTCCR9l0lVgYuuEidv5Q2RqhEiYnJXGjE94Hy+kQeWaRSBC8PLx4LXPp2owbrLz6Kwg8+XL6C
 CWUPQuVsS2+ArRWIFHah8HmnFyAeXll+G3JqED6x+XEqoAxhCKaKcci
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The 'uevent_filtering' test generates an object with the same name,
but there is no .gitignore file in the directory to add the object
as stated in the selftest documentation.

Add the missing .gitignore file and include 'uevent_filtering'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/uevent/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/uevent/.gitignore b/tools/testing/selftests/uevent/.gitignore
new file mode 100644
index 000000000000..382afb74cd40
--- /dev/null
+++ b/tools/testing/selftests/uevent/.gitignore
@@ -0,0 +1 @@
+uevent_filtering

-- 
2.40.1

