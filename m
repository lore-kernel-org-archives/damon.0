Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435137;
	b=BMw2di1U8OXI3aU+W+yDMoDgErJNoz/UDBJcFlBpA4sbCqVOLB81nna8AFp/79Q49W8K
	 tNsbcFUuROcATrCu/wf6CWZCy1Xg+njKTuioT+HzaRMEh5JeRlhslOXGM/GxsEF57KNKf
	 6R+Odan4CC8K+z8XoSuMAL7dk+uf/t4HsKaR4DxO6gN/olt2faytChtYMRGQ64xflLv1e
	 BhyWYYcn1Cf5oTC8kXk+um62mEMKgqe2kKPziczG3V+WPyeMhlPrfTKtWbiuW4A+uWWgb
	 Yk80+6nOQGpndL87deYxJ0x8+R2/DbfEty4M91SREEy6gpUzBEJOaEkEF4SaH4iDHaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=B6js7ztezthXpHZzjGx/lwzyYsi8HVANsbsOCwVJ7Sg=;
	b=mA9LUEmzWWT8j6nsPv+GwuJBS/0w/McB1MSbDq/c1ldG43/+2+VCdvZHDyk0+ww6qZGM
	 Ah+9mFFURzGjrvYYPBwQAMzsPlZqDZ3gC2Qa3PNyttr3mrqeEbZA1EeVV1njHlxOI49PM
	 cn5HTu6d5F+gtHDs0P/nM6cUD0Rju2e9PD12g8s3StmXBIyl6sgsI6z9dd/9eXOQvmxRr
	 Mwo9qSq5g0rWfxUU2aM5F6mdFsvXl68lSgFeH3c0cRemd1TM6pVaTbsQsSJE3xHV5f0v1
	 sKgk6yKJYv1nSCQqEwXrojQDhNwVigUeR+lyoXfdnKa3cnTSK/W5AwF+PZYYv+QofZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="MwcUvp+/";
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8340606A31F
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 11:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8340606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MwcUvp+/
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3b4944a0eso2153316c88.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 03:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435136; x=1796039936; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B6js7ztezthXpHZzjGx/lwzyYsi8HVANsbsOCwVJ7Sg=;
        b=MwcUvp+/uBvq2HbnADfFilWuTqSVkXrz5DjhmwXpsM4F4YkKuCdRo5t/o1Zki034a9
         Lb5iHDznym/j3SnYqyVzpelfxS6TUvycj6rhSLXyfCpDCTmR8yuqy7aYZMW5cRz2yyJb
         XT+u674mU3YdCpfnY3IeLoV1WMq7GFSmfqeC5Ri7PGZaCMoooddXZXjaPjNlrOkYE9xI
         JrWV7oZVEVVyKrSNcZ6bYHKjIz/cmVop9+mVYsM0pJ3usBszp65MSGwpyTfacwgyKr3c
         8jIOTc1UNJLenw+hbShU+5MDBaNd2f0D3brIiXZliqUg3rhygY4ldh3s5dB6Nj1eSTSg
         zquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435136; x=1796039936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B6js7ztezthXpHZzjGx/lwzyYsi8HVANsbsOCwVJ7Sg=;
        b=R6Cy7sl7Wkdq40y4ybDph+tm8106nO8sqSE/S6zjal7XZlzSxqV3HQuPZD5274YE6X
         G5CiV18B2iXd/iLB90O1F5tVYtcvQGfTjjsZSS5dK7ChoIXmfpwbm2Af/Ehd7EqU0b2Z
         CMrGaM0nXqN6l+2MyvzdqyZpCM8n6FJIujRxeRm09hk0uoQl0RUTz3yIGRXpemj31hDF
         QKt/5qYTJ25BqdXLwkyDEkqiEsUYwvjNuYeGnEppiAP43qtANtIqj5JzeZ2IgRuGena9
         GD3f+Ku5PIdPPWyZU/UOy96e3CNwXUvvtZZMjGbYMBXDYX1S9YRTCm1cteqSkp1mU9XZ
         gsOg==
X-Forwarded-Encrypted: i=1; AL+hErGklT+8HwqdKSGboB10vLTuN8KH5MHYSVrKYmsPI6iH+6QW6qyVxnIdVupqOCLjfv+wwHobRQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8TbH3w9M4Mtr2nl5S2rhkm8UZC5VFyRLMQXzQYUMWGYDDCMcJA
	ynt1v0gp3zZE0ISm2POWCr2yo5syc40b5S7Z4AI/JMlxRvsjiJAKublr
X-Gm-Gg: AZFdTZdc/DU/tFqJW3tS8UAyoOM7KSNfWR2caGkncFuoH2XEfUtiSQOU7THNbzu3GlP
	Ms058r1fgn+YpzKk4VdjKyT4LN2jEtltp/VIXWEk+Q0O/bBG6GddmvYbSXTALWQakTruIQUW/6f
	2AZEMrfKrjtrRmEWlPXMwP3xzsmCkEdFq06nEva50W+Wld22F6x416o88x+pXV8XrIy5opE4Y6m
	tCX0fwNokoRfu0u4ymufnaEOiFVvoICdEdI9VwlKoeWMJ5sfi2KvE/pbHBBKxmeett38u0ROxrY
	YiTaflGBYZyBej6kyk1KbOxMl1yGOzpWfIkmSWa0DOz958qoNVCde7GsZ3Gj2e7WUR+YcCgWg0e
	U3xO2UfzdfArAGLTKyeM8NZJb5ar1yOV0aL/ztUMEPeGfskrpWCbTLij2YEz+Ycrz2XD90os9qu
	OC/cymf6s205fIyKA6PeX+2RFheycVVuQSRlu7Au+546rxPCvGyNoJkIcEJdsPdoKd9cOWcneHU
	SM6yNxmBE1ZCCueQYe3n+X3e/HiIlT02Ce+OUENx40R2AOz2vUZIOHx6sfh9K59W2iSL8qYDu1G
	lvSLZoJQ0yWQUDVdvp0nj0gsWDp4cniQFD/prBoBZIb3yEjG+WM0w7046T+pbOhUYlBA
X-Received: by 2002:a05:701b:4291:10b0:1b3:af3a:e78f with SMTP id a92af1059eb24-1b5568e10ecmr11698042c88.27.1795435135970;
        Mon, 23 Nov 2026 03:58:55 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55682d301sm27972005c88.10.2026.11.23.03.58.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 03:58:55 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 10/27] Docs/admin-guide/mm/damon/usage: update for report producer sysfs
Date: Mon, 23 Nov 2026 19:58:40 +0800
Message-ID: <20261123115847.8976-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-11-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-11-sj@kernel.org>
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

On Sat, 21 Nov 2026 12:59:54 -0800 SJ Park <sj@kernel.org> wrote:

> Update DAMON usage document for the newly added report producer control
> sysfs files.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
