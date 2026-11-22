Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795357830;
	b=LcGtaxmN5/Hei7C1RPQFA/RvrcitvYi5le7XVg3aLsFZJWxU7bLCdWZe6euXKH922Kfa
	 vH2N/Q2s9Lfk6dLrkaJ5a4eJrDj+ytXy/7cEYLJorsuHYgIBOCR40XrntRSwYtq3T04Pj
	 wMnB9AZNIZk+MXPHmqNdQ1VOiNwSGIl+R6MsGiywSJgec6C3hQyac87dXxQWYScXkalAE
	 hbfcUV34gQNPnob+O8v3a+dvv2C6YXX4YPTANDmFbaSH0ewo2H3yRut5nsFmIhnuLJ3xe
	 Bu2mEkYx/TXQNcy3Ympx0Ol9HC7ZL8plmOh15BNT51WZspeKN+gJfZIXeb4KEoL6p+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795357830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QBjN2nkZH7Gcj/ZwiauxMt+VX48sTrjkI/4AB/9s0ZI=;
	b=lh5I0a+XDePGK/xWdJrHUirt8aBQ78uxNfC3Q9kydsL8brB/udTYGwZsTdO5qIoGmCpw
	 k9O8nf9fUDoNVUxf+/mB3XOXwxupuLRPxngsczWlxDRHpByUPW7sdFTCQ5hiu3SzpNWPl
	 Xm4cabSF6+tBdVUULEBNUTIB6LM7AIXMO3hzk95V0UzVeKiYiYL+RTt0sh0nnR0OaTowE
	 j/U/EOOOAt4RfmCJUd7MdX/i2B178kUaVVFe9LhWfX8AtSPtqRS7u4eJFKoJdjcbn92m1
	 7omZ3MQbgVncGgs7m3FqJYtu18kHO/GpqvkX8HO+81BUaLkA0emk/EvOu4ol1PnzKDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qT7gBbD/";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331C606A337
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 14:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1331C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qT7gBbD/
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-386ab9ab619so582897eec.1
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 06:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795357829; x=1795962629; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBjN2nkZH7Gcj/ZwiauxMt+VX48sTrjkI/4AB/9s0ZI=;
        b=qT7gBbD/tBfC97khl9LJagMQdXSylQMZKZWW3Dxz4Y+sDR3CAyJdYJ78kXd+fTOAEy
         7UyPEVfJ6PSK7V7nnG8xMnKlymukIiyWq/X3q08kitqJdko11MHrylPJX90D1+OwVbnH
         ibXJBsO/jcWynzAOr96juQXDuKqjIGwwOGXGPbdJ5kvmZLVLave2e9RrbaH+36PWMLu8
         5Xy5a6vRFFA97QSZmTDGNt8PppQPJk/iUO8fNb9/8qEgr6jrjI5Zj1jqMWU5j/INTDLG
         ebiM6/khWVDSNPPkA/bDg+0eEXf+zwWU65gLTKM9Vep9FkBGqsHX+bEsPMkxj3Qd3n3m
         xk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795357829; x=1795962629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBjN2nkZH7Gcj/ZwiauxMt+VX48sTrjkI/4AB/9s0ZI=;
        b=IWDJOlYcTihUO0zFZml91578geb/7i9QPOiukWdAVIDsDagfwYa3CvIlCtDZqTYP5F
         HDQhJPh6u8xNzSHP+EXut4DM9f6anVzi/I58yJ6rnAzD57Vp6mh32VqRWmelnVLVjO2S
         syQtDtETQelK3mfHBcmGxH/OXzZeJkwfTgZ1FkGPD9KZVO+96CPVROCmXqWIEfpBsJdX
         gUB4s3EMGm+FlMo5gaSNfZVcLKT90+i3BViU9UPSSgSTCq1Evk2okVJ1Yf/LRP/sbTu3
         RtRZjkDWGNba/MSWl/dsElZNBMO0e4xfX2TlTpqRG2QoVSHYbmu8i+2D58GBsBaOIT++
         I9EQ==
X-Forwarded-Encrypted: i=1; AL+hErFkrEaoABC/hOoaFe1LWZi/LZFOvutr0Moy0zDTrvJVd01mPqYqqBLdWJDdZaFUhvTV0NYr5Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+0uRxBNZ9hSNaE14v01+g3XzO1FC8jyBr3itXA3ggt0npbotWk
	Jy4oNjUPWIYwO4S+G2J0mjNirVIOsh45Z1lm1P1ZVAkYj5lS6tjYda/4
X-Gm-Gg: AZFdTZfU83plkWtcslYu1O1wEptL5yqK8uU8tGve0V2N8oLEg8KpYm4sUbHEtAcOvc6
	84cpeJTRqjzKbM3kcahLiFbqfy8ImhQpFzMRwSVD/FEIgp/eDyg/vGZaBnMd3FpYFPlM6K+kCij
	/K6r49GekeuGaqGwKJPwPmOcm8KxxKvQdkkLdrmuvyUfZT4nNE2y4KIEA03zTp6PKrttBPs1VSb
	TGKOaruZrG05AAv8sNBcNxTOtdcLWauHNWPC6z8yyw2UO8eG2Miy7Ri3r1O548b0K4eniQuRauo
	tOyGoym59MtxKKwwzdYj79ye4OjuUOCh7RXKw+Atq877IMAlEhPnGyfJR63IA9eEs5Ip1ENM+ie
	uOS84W5Ct94s2AKsPnfqchyrMMf/CmbKDv+uXviJ87EX36Ry1Zj2ZfWnTrhLyLcDPQ85RH3Dgli
	eFai9lxiNF1QKF6Yo2Irx7N8fElr5pqqU3FzWo/cEIFWoCoME+uJ7rPG2a+wn2LXFKR4youFt5Q
	vTeOWPMREmk50Xtj0thoYKtVlpLSmXrsvoHJRt9F3RuyQbCZ0G1FoaRm+6x7NOlwrJ3QXmaEyhG
	pYtXSN5fHLS4HdxkAujnTMsm9efAS9wzKBWbjyoW0IGDsZ3s5+EQ5lcDNVUXm05Z6wX4YcPjuEM
	h4+Yg2W+OjV51QA==
X-Received: by 2002:a05:7300:e9ce:20b0:36d:5102:9974 with SMTP id 5a478bee46e88-3856c2c2123mr11231914eec.2.1795357829128;
        Sun, 22 Nov 2026 06:30:29 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385667decc2sm27877901eec.9.2026.11.22.06.30.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 06:30:28 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 00/27] mm/damon: let users report their data attribute findings
Date: Sun, 22 Nov 2026 22:29:52 +0800
Message-ID: <20261122143011.85844-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Nov 2026 12:59:44 -0800 SJ Park <sj@kernel.org> wrote:

> Build a system for letting DAMON-external entities report their data
> attribute findings to DAMON.  Let users report their data attribute
> findings to DAMON using the report system.

Hi SJ,

I'm reviewing the series and setting up the tests. I'm also working on
follow-up test patches for the report queue and its sysfs interface.

My schedule may be a bit tight this week, but I'll follow up here as
soon as I find any issues.

Thanks,
Lian
