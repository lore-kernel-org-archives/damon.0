Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368739;
	b=T/zi6lvj3bui8w9T6menuXBYPS9DQjtQTFVr3CQAIwIJ427dyp99jkV+/J91PcpxSMzu
	 zV6Je6Ntsro14v9Whjy+CPRJtTtoYomxXwx8Ps7CvEHxD5e+x4u8prwWRz3FqQmRn+mEB
	 rOz9v20VJY6xM9nNaA1ShJL6d5nKHeFUIRzBAxBpFVncjJlMvZzHxYO9F4+HMx9SEKdMj
	 KrNEWEt+eNKY/BTuR8srkqxmZKQdgQtCXWQLFcbUKK5EN9ClriWPqO62ox1uYuhE39nnY
	 YAW/KA1othpKQw1vWVqmC3Z+BydcRZw97jzQL6pn+bpsD2TqzsQJZsmHAepfmn9gjiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=96+Ra5zxNltRU2dUwkJA1qT54mu0P+GyudrjkcDbIs8=;
	b=C6855KcGUIwrR6GFYIpUaEZ6VWqvTUw+tYDEvYkZZrYAlksL6lyO0pJkct3cINhLQdjl
	 n9BrZcY3xOmEQ7m9u9UF6nyhuK2J9N58N83GzAQFN98jK5z1wXqhDdQ8qqD+WJ63iHQW1
	 ATIKI1vwj+7/dZvopSXUE43de28s6RJM4DIXZRfWHpfbIQoNOrh2O1Acuw5m2jbepSITb
	 gWUk5tq0HyBCIflSdkCwT3EPl8I3c7FhjI8EnJV97SVK2WDcVR1lnzUlhctFBDvXnfOTM
	 Gi22Yq2a1L3g8Yte2f+KV8WLRNzTny7+Iiw1hxkZB2XCEhqo+nMkVyUUYmXnaZP14dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cDn0WAhU;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E6606A320
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 17:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC8E6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cDn0WAhU
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3b4067446d7so397610a91.1
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 09:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795368738; x=1795973538; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=96+Ra5zxNltRU2dUwkJA1qT54mu0P+GyudrjkcDbIs8=;
        b=cDn0WAhUNut6KFrndvTUjsouz0kiT/mLC44uAm7ELRDXyoc7fylySQno7+EoDougzR
         IT7UR2Ott3kOHVc+73zS7UIbQRcbeIp4PiRqftewkDwondWMwt/twjOxMd2TLwLNgRoH
         njT580yk+lGfVA/9P4doPWNAMB8R9y/Uy6Cr9YohOBrMWrr07Vtovh3Gf3aqZ839U6GE
         7+9xEQe95mk8b2aRzl4Xpb00b41zycxdD+eAa3UN4HuvPIdTBfMOV/mLE4IOE+OeuWo2
         OrFQF8STm4QiDgIbOz0VGvv93eqmlCBaJn+T+eGJEP5gh2gwh4UuPzi8sm8alM+tBVUS
         YKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795368738; x=1795973538;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=96+Ra5zxNltRU2dUwkJA1qT54mu0P+GyudrjkcDbIs8=;
        b=xD2sWldYL9aQPDt5O7st/tzefJE+efJzFMvQ+J3QqJQlnwzovni51zhLaF9fwv/Gg4
         zgeufeI6iy5/ERPOy3lMQiXAH6nwSwVJpU6JJBq+d7g6Dyv7LfLn3q3l7+n3e5VWaE1q
         V/v0IDHqu+WRLZY6I73G8SF/KwiHH/mZwY283A9uzMKtfkvH3NSbbm5ZsRZkYdtCIZKL
         hwkHwFQI9TW2YLM5SN6js1RGnSEMpzaEzJUUrxbndlAHnRl7cShmm6E0V2vq0zyk60+f
         KBy9OMU9VWaKbF5FDU0NOdA+3ojBFAyudvzgL/93tA/sE/mMj8EqumcF/kN7cLUGQrgX
         VXwg==
X-Forwarded-Encrypted: i=1; AL+hErE/ouQReudfEOyB5cKp3Zwc67eIoUwfnfYm/3ThF7IkdZJChd3Yp3gTj7yGsS5yyUkkIbK7vQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/Hpjr86QmUC9/SatRZbSNAWx+46VvdxqysGeQycsdFGLtBu4Yt
	qAO3MzP2W7L6dD5H2ccvx/sVKCbqJ83b8Idt9yTCfk7dX2faaDWSxPpokY7l6GVd
X-Gm-Gg: AZFdTZe+b33802qgBQofTjgt+7EUaEpv3ZI11OuhaYUnEFBpv/vMlN/YZEalgl8ozAl
	FhL/KJIRmAGNZciGpThkmz2rNzc2g7Hti6XhqnP6yjD9RIEkLXRV8rk9dbil9sCwkMxxqNtYc6J
	vs+kcpDg1xcUZe/wXFxKPveng8uV8nPi01zPRZi74jOUABR/juUmUXpcXgNqb1c9TFvL4tNB/ys
	2x/uj4nI0pz7vk6LBApHXXZRcb5AeOZWq8RlG4WDWN1YskhIKA4yeiXAbDiCnIkjqWbEtg1L+ib
	VoAqkK1/8JM7l3apSDH2JUcQDyNikaUxcHlSFeRVNtaKPtyMfiajFfU2Dasid3yI6qU8eu5B5rX
	2x5ua3FDneFjIk7ZpPyjPcEX80jkhmMh2HjP8gm1XYyrGInHx3LBlOkANqwgveWP1So9dHIAHjT
	Cvp51OZt5ArHf1FoAur+logEMdV5B7JnfXicoltubKfzOc5GqW+SCalyY31sc8yBUeVpFPZskKO
	gpVvGb37Hcw9tLEl/vRkZ/lRqIjfuPoTT+RECfbC6tP8VmRjdBJXO93H9o46W1j1bmYlcXqQt6f
	1T4NNj70T/Zz5d/6HmZYov0pdj8OhMB14qxGZIPG3ibTIfnP6T1Tm1u7581Lw5yfoZGwQY4NXWW
	mmUu/ZlZBzRyTzhi2J/AKvzSzm/LrXDOSZNoWNErvzIL5piE5IRgt9PiLcapdCg==
X-Received: by 2002:a17:90b:5303:b0:3b4:41a8:7850 with SMTP id 98e67ed59e1d1-3b441a87c7bmr5492062a91.6.1795368738095;
        Sun, 22 Nov 2026 09:32:18 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40578dca0sm16955781a91.2.2026.11.22.09.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:32:17 -0800 (PST)
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
Subject: Re: [PATCH 03/27] mm/damon/core: introduce damon_submit_report()
From: Aveline Noir <jm5905938@gmail.com>
Date: Mon, 23 Nov 2026 04:30:26 +1100
Message-Id: <179536862669.5.2109435867001229835.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org
In-Reply-To: <20261122171525.153150-1-sj@kernel.org>
References: <CANOyQmH5FX18LmMW+QwAcvOiATgUqx5VH02S5DyfTg+qPMSX+A@mail.gmail.com>
 <20261122171525.153150-1-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sun, 22 Nov 2026 09:15:24 -0800 SJ Park wrote:

> If you don't mind, I'd keep this as is.  What do you think?

Makes sense to me. The rest of the patch looks good :)

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
