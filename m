Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C8481D0
	for <damon@lists.linux.dev>; Mon, 12 Feb 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767024; cv=none; b=bJMIc54lbvYh2q1tjCNBevWzDu2hoE6FnYXwNZj0sSb2MVmtcf6PcoJlOxUbTXHCYq7GlTwmEnohCBHjEWkacAu8c3L9myYJyckd3C4jcWcAXuZ2T3II39jUwC2dj6CAsVNTkcQE9c6yjBwKpyCfYkTOZB9xXQ+wqv/2/Cn/af0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767024; c=relaxed/simple;
	bh=w5VzuQadUGXDHaurnkp1xJatgCg2tWCeQ0RMcYcdwcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=niFxYcgaNwDhPHilAg2RWeEt6VYIOAxlttqJMKv6szaNc3+u1zCbALjTwd18clR/1qOCrXRmGk4JeCtf9ikgrlXYsAV2Jua3GYfCN6t+yEyC/PmM1lqi001d898I4U3RdexUTql2FqkhBq0RGdre4Bw5DfMYivB+8T0hHslmqks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byNKhRrD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byNKhRrD"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so20899866b.2
        for <damon@lists.linux.dev>; Mon, 12 Feb 2024 11:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707767020; x=1708371820; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GNDHPu7XhKcCz1lLARLwTjps5fYGCjGiEa8mM6D458=;
        b=byNKhRrD0h85s9f1gNAwlYvJyBhJt8Sl3jSy1vfXIbByrL0TQpXGwfhFJFJFaKGY4D
         3k29ZEWsxBYQblaXuXm7LMTFumaPouMXTsjwmjfA2O4xBZpePt0tlhYB8Ue2Q74OrC42
         g4Hc8FSAOObWrp/4BGtq6swHPUdDZ/ap40d5QTMyLWu9m3ylYp/TJv1A5yeHupDsMJ2C
         8hsY28W7/aWFxuU/DmxSEcpng9NB/ulqbZTjKTBm9Y1PS1AFK/EO2bLaHQWkeLESMBKo
         00lCAJCbjOJYA+PKTcegIMBIVEfuJ9fvt+00aJ1u5WBlSzqaG8y0YVbJjoVzmHcJHOD2
         PYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707767020; x=1708371820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GNDHPu7XhKcCz1lLARLwTjps5fYGCjGiEa8mM6D458=;
        b=j8mioa4IotaXKw0katG7dAAEb/+Tm3An8EWZdGJxCyq6LeuG2Bp8LIeHQXrTbcHq7m
         hfqxYCBvChX3/vO1nYm1OQ5fCX7h7Ty2KFWR3oeMlURhgr51b0o8vjFqrTMSkFNeZ2A9
         Ic8ubuVxk9A/OgnNCm/lwRWPTyoNGMk+otmE6kZsaKolWuN0WM3TtuJN6I++WbR+M/4F
         08Zfq+KukvFGpDUL3SlUObScJy0szAznKLVdHUJqeWyNPMfbvrIfK4m8sgpoJXCgwRKJ
         bHCESAAwroBpYysY3AOCXePuqXPDFOrsJn5uqF0MYeigsQW9PvjLz1z4jyqdynCQJZRS
         HVTg==
X-Gm-Message-State: AOJu0YzkWdX2OPM+sX7KPHYfczOtOu9SsRJvm6Z4nTp9WiUtbuDSE0CQ
	IeXz+mduWQFErVJEbMHBjYzhHE687AthJ0QzUC4JeXGBz4R1px96hQvSdKaKoNYeJQ==
X-Google-Smtp-Source: AGHT+IEYhoVKt6+ph0IS6aNoOBB2GhXkcHadPbmFd+yeLBLvAD9woPDg3bX6Tq4y5ucJawuRvTz4Tg==
X-Received: by 2002:a17:906:e2ce:b0:a3c:8d55:bd7 with SMTP id gr14-20020a170906e2ce00b00a3c8d550bd7mr2681537ejb.23.1707767020593;
        Mon, 12 Feb 2024 11:43:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQX+FVohLVW9V+EuI5M+OMnY/4RbHojcf09owLeeu+Vrmfcsxpmy2iXuJa15IyEuWg9IlhKLGQ16j06gjlDc342+M36uk5KpPe6/suhmsH5SrV1yPfw5FxNoLwsOOep8vTTDdarZ2x8xW9jHo18hxbQ/febrkvQVY1wk9Hj0YDjnXohHvbc752UnowefVkkuqCatr+7HQq0us97he60OoWByZ9SQOWKOe1uW/4gtU4VDxr42wgLHzLem3kJTOXB+JR
Received: from [127.0.1.1] (2a02-8389-41cf-e200-8e14-1b8e-d285-8c63.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:8e14:1b8e:d285:8c63])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090699c700b00a3cb136aef0sm502323ejn.224.2024.02.12.11.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:43:40 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 12 Feb 2024 20:43:37 +0100
Subject: [PATCH v2 2/4] selftests: thermal: intel: power_floor: add missing
 gitignore
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-selftest_gitignore-v2-2-75f0de50a178@gmail.com>
References: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
In-Reply-To: <20240212-selftest_gitignore-v2-0-75f0de50a178@gmail.com>
To: Shuah Khan <shuah@kernel.org>, SeongJae Park <sj@kernel.org>, 
 Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 damon@lists.linux.dev, linux-mm@kvack.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707767016; l=738;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=w5VzuQadUGXDHaurnkp1xJatgCg2tWCeQ0RMcYcdwcE=;
 b=U9JPqhmipPaxTM+qc7NP8sBbNgbXPf1Aelc2TmOFCe1hKrrw4MvUlBCldhUaovyU87CyT4sJN
 xDoY87TG4pBBOMUmJqLcJF52w62kBmpI86jTFlN9SrJIA0UFK2YxUZc
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The 'power_floor' test generates an object with the same name,
but there is no .gitignore file in the directory to add the object as
stated in the selftest documentation.

Add the missing .gitignore file and include 'power_floor'.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 tools/testing/selftests/thermal/intel/power_floor/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/thermal/intel/power_floor/.gitignore b/tools/testing/selftests/thermal/intel/power_floor/.gitignore
new file mode 100644
index 000000000000..1b9a76406f18
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/power_floor/.gitignore
@@ -0,0 +1 @@
+power_floor_test

-- 
2.40.1

