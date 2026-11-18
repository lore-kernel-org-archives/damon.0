Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998083;
	b=aVqzSoNAcY5AI3coXEGdOuZI8wMriHMf53VElhyffIIBOz8ulqrLt2eRmL2Bijz6FyE0
	 Z9QNaHhIEzWp13Bo+de8QIJkSG71RHvseL6e022Wk1L3jIuX4noXK7W6jdw0iPoG9RoHt
	 eNuwCV09f5SpLAm6aIqRYvWMwSdRdEb144ZWykQbIRH8mt356F4c2h52NBR4SHAlB4KK/
	 I0+T4P4vMFR0CJmY14SWaD6L0kM76CsElB0snR6xxKRSMFC/AM97mO+Sulp7NiZh+Fsn2
	 xG2G5tnFyNeXLckL+zBKcUDg0dHg7z37PXi1DNtCGHVTqtbdJHtRscAWVs0HAy9dwzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:Date:Message-Id:
	 To:Cc:In-Reply-To:References:X-Mailer;
	bh=VbnsRzldWLp5RM4Wbi+k8602uEkMWd5FOiwEB3P+mX0=;
	b=H/3qsvewArd1oewaUx6hl6rSt5J1s3dHCYJD755S2PN1jqFdcRlmGqiKx22ml/R9S3U7
	 fphLI87hb61h5eSzyNZsIckUsl0EDs45BuypvVd3NBxdu/fImrHQOomzP8Lv6Ti4+4RM0
	 bwD+ioBRiFQU/1rBUreHEMo6vvLSHruHoAb/0lLXqF0P8hqJtX15sRasL0aO1djw5CZ8i
	 wkC8fjvM89UQU2OQ+b3j7z7QDYrBniwwazSkqVhcuxoXzFpY0HXCuJ+9BPAn/1R3HFocM
	 fD/Lw8es9Qf72DH/0eF0TB8UOOTSVSM6zXglJFkYIcAvpnFMGdjABPRAH6r/h+eupDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kVWiv9qr;
	arc=none smtp.remote-ip=74.125.227.129
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638E606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 10:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3638E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kVWiv9qr
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2ed408b0d0bso3794965ad.0
        for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794998082; x=1795602882; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VbnsRzldWLp5RM4Wbi+k8602uEkMWd5FOiwEB3P+mX0=;
        b=kVWiv9qr8mfW+seK55oeqju0a/Uhng8VI1B0bpXRr++gpbzod+Iw4MGTXGfQgPkTb/
         H20HC/wiGrxCx4vjVB1ErpV2+l5MdzO6REfzJpsS0QBNGeQop1G3zuejGgG4MpiUJNSs
         uBbAPev6LCNWi4aIWtRG7XL3ud5M87iPJFxnpJg2FXPYJBOEmPuUhdQUzYqIprhgYV9N
         wLau7Y9HFbvGGV/RmdrVc3SN/7e0YsBDYgAMIFICMfnLg5IL+X9JdVvw3BbW79d6f/Ur
         hlSrM6RgclZjEVNYcjavbF64hN8Zx4oYE9W6vyrNInFQiRZK0TTgtM+KAKX2HYaUCM+j
         Ockw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794998082; x=1795602882;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VbnsRzldWLp5RM4Wbi+k8602uEkMWd5FOiwEB3P+mX0=;
        b=t1PVfzYMEaR/udzpIsER/li+5LgMW/N2w/TUBLwCAlSEiWpap9sBaWBkhnFpVV8ACj
         5eSc7c97CRo3/WzXXHcmbNGBRyd51oQoLoMPyhB0iQFPPtrK6pIPko8nQgJpmfa2LB1d
         eb1MVep+8OW0ekuHEiO2X93zjyPW7NV9ylh7hLfIZOVyhXju/+z4DxNFIxorLQv7k+WJ
         B2QmeAaWeHEJK8cKJ6AgeZcQH3fNn/2igFryXIpALtpMmO/qQCs/HGlUH5dum0Lpvff+
         EkTUr6ZIZfbZqUMNv7lQ9OTaQ8h/iIrLsJuqNdGGProSROiDGksHAe/EidL9XYZcnNH1
         NG6A==
X-Gm-Message-State: APuU4Z8mKU0WLKZ1+eeIx3kFREk9F/ouJNCZd0zqaGRw+m50RHmrTaDm
	iVkCwAAeg3ajuXRngapQCeYEnCtHq6Ixre6jUpyhY7pMygcWU+xMrNmb
X-Gm-Gg: AZFdTZcaA7sCy6Aen3XHVMmUeg7TZWZLsYhZjx0Amv8+K3g42qxzsfF81N9tVYYPHkE
	kWjxDFMTcLBX5gA+NRs94lSNuQ1hPgzTKp3GD2AmBKOAdw4Rte9hIqFYg+Wiha9XK9YrG7BRHWA
	HIPcTI3vnCjiwbQlX9283Wu2GkiYFdR2S6vOCPekXhFwfa8JZKkwjlpnK0DP7Np+nKqP6JJ3gC0
	Vvhm9iup+WXdGUlawqLOCqauFNKLDJnu5SijdCXKq0vKeQqjykXD4kliSSNgCK9XaL88RbSX5m5
	Eo6oZhQiKP1J/KuakX32REXkhMot2hzCP2eHz2eloXQEDxOstKs987VdmacO3Tk5F8XZLXuuOUY
	zFGgniQO7uEBjgM9NKulMweyM0LmbpFWQbyU1wxfYrP3+IoyS8aqPLoAMHSajYJVypSnpIHF7dG
	Wcb5ATplGrm/3k24LunqJfWmPijlq0Z8ujG8nWP1INh4kN1gYpiBoeJzeH7MW87xsWIcshZPV7J
	KQw+dB3SgRW5+sspKSmyAPebVArf7c6l7SkslYGorW4e4oRkMXRqOuxNWzrwctLL/Tej09O9wH7
	eoEyrULMQLeYwbd68zAfmDmZIJm3N6wEi3SsN4MOZFkPSX3v6XCujn4rvhVqi77leH4m7g7Ruwp
	CCHGC/Dydor0aSd+bRz8qkRNMg+1wo8bcG+rdOIVLeaH4sszxc667+kh4ifVE8S7i8wnRrD4+8h
	RIgkIu7dNs
X-Received: by 2002:a17:903:1ae4:b0:2e9:6333:fbb7 with SMTP id d9443c01a7336-2eff756dd79mr21077005ad.51.1794998082258;
        Wed, 18 Nov 2026 02:34:42 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6184152sm10914405ad.35.2026.11.18.02.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:34:41 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] mm/damon/tests/core-kunit: add test for
 damon_call()
From: Aveline Noir <jm5905938@gmail.com>
Date: Wed, 18 Nov 2026 21:30:04 +1100
Message-Id: <179499780488.5.13594313574604410531.b4-reply@b4>
To: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Cc: damon@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, sj@kernel.org
In-Reply-To: <20261118063755.37749-1-saileshnandanavanam@gmail.com>
References: <20261118063755.37749-1-saileshnandanavanam@gmail.com>
X-Mailer: b4 0.16.0

Hi Sailesh,

On Wed, 18 Nov 2026 12:07:55 +0530 Sailesh Nandanavanam wrote:

> Add a kunit test for the two cases.

Make sense. Thanks :)

Tested v2 on x86-64 QEMU with v7.4-rc3 as the base. All DAMON KUnit
tests passed.

Tested-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
