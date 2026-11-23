Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455546;
	b=bVXFCr0AVlmS4sTmO4vlO3hTJdB/22oY+GlyeJp4p/43B0y2IkNYrMvoXc72I4wi66gN
	 t4t/6VD/Jr6S20586nLFTAGAEslbKTVdpJ/fsCaDGGapoa1EO/CtZ/QSRDxlyTXkqJAtk
	 gm5KBZIvCrV5xW+Uaoh1nPr1N3Vc5qSerp7ZLT+XrYpBkkzmIRMBkdV3EsUxaVgp0n2jc
	 AsA5npGxg3eUAEmGomW83woWNx6UlHxwP8bOKzSnIv/RTBgHbz9+sJCEl58llMWtm//AU
	 YJaYPmNHkc+VGP3HrWbYcW1+HhdMPsReAwHFd5hhowcGAPAImToIYlBkeB1xDDPM29A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=6/YqHUloJtkZbpJ39+cQO94H2zNky60itqgdCHgeegQ=;
	b=ZyQDP0cZqMpYVIf7rzVxX3NqLhERP1QjxzmxLZNhtpUgXRNvemiCrIqnscCs6IfYpsFA
	 3BKzjXzcv/VvYyHaTjhIqgPcfQx8fl1aLRIErui9n+S7dMLiHQJDKf4xCZiB6c7P5GRgq
	 QfjvlOzsodTbBMfRdKf4/SC7+g+am+nz8R3EcEEw8zk6zxgCT5IfL+m3zE2t+GIP/ViOI
	 7M53pitgfxENaXvVctpgF3puB1W/lNNIC7TroiWhGZfw9COGUCngUCYPCXU/ILfJRus/d
	 qQa6I8sgKtk2VSsfxzPZQEgxw29n/3oXm/hD3ztgEibHpusHi2OG8oZKxYQMm24VH7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qkjHjijR;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D14606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21D14606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qkjHjijR
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-377157fde7bso1283491eec.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455545; x=1796060345; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6/YqHUloJtkZbpJ39+cQO94H2zNky60itqgdCHgeegQ=;
        b=qkjHjijR2JtVwxzPH/wyOTQCKuV8RYnzEZ9cvHN0CupDxEbb1z68ew+PKPxAYPcBI7
         ohw8AEPVaVwbblQSusstovL31xTj9gPRXaspT4pY0Wjbo5eG3/o46QdINLAW+6V6qE0c
         hUPQ6JOBMbXQFLj1zaDHWFtXGk17s9tirghsEnD845JzvdH1oB+XM1w4qYd18HeGYWjJ
         mHYRgYqEULHPSyarTXySHLDz8gOMZSxr0jal2oXW9OYUFC1e0pg2Yta/78JmWSTU5hi1
         UHmGhYTzs2yWuflE/dAvm5LP1AS+HheeOh/5UV5yet8BvH1MRdgJciNZFk5EIrAdaOfR
         kvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455545; x=1796060345;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6/YqHUloJtkZbpJ39+cQO94H2zNky60itqgdCHgeegQ=;
        b=ggNUjCT7LM1P+v6GYpy3lbvVA2z9d/J3+y5AJvd2K3VPON+EStMC/D8iLj/ov3uRuB
         8KPT/PWt3xl7xoFMyt7I6MLYou3gW7+LuojM2ie4rO2oqSR4poG0yv77kvsEFVmaVo1F
         ca16h5728fPhf8DTiE/rgE/j2MzyW/Y4w8pBaX709d9v91bZpYpg4rO6qZZv1stayFka
         dzvqkuHwIVT0OswK+3m3N/OyGKjfdeD2Vo0PClBfJykO7mnWqLHjkHUtIFONr0DcqYaI
         DQiVkqguH3KcT5edsmuICdLLcfsg+XVdp6N6/tF6bphTehLPDsQ45XBavmQAUnuLtU+n
         OFGg==
X-Forwarded-Encrypted: i=1; AL+hErGtgT30vi7ws+llqU1M9aGlX8ZjzVA2u6F+mJL3+mc4o7TDNGUFR1SsX0a6XAJT2RpZP1smcg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/jtpPYXx8vbMFypS3fkyCjk0lejMf1ZYtA5Dt6yo/yh7VhX/d0
	p0UFxr8sE6+8Z9+eTtCYuj9T03fDCsoByKLJr97eVfbLoO6JFfflLS6k
X-Gm-Gg: AZFdTZeBq6UoK/o8uji/r72G//032Cxl1568chHNwW0PaMIs3Jg9GqGPZyWaZ7VBfkJ
	0vTnMy2v3Ws641OyyQMmi8I5wJL2TLiMJNWN9tD5pALBop2lvo/6ShZs2+rZraMRz0trezmTSIP
	TsOveFeykgNtWtxRcTHvPw0mOH22mc5Z5G0uRgow90JPidnH6KMlK5et+5uJtRMKLwGL54NWblB
	J/SO0NTxlx8cl6orVryOQbBc1D0P6//Ai0cq4JehioHWNEYZfqz6sgOQUixux26i+KJ3SCUIm1M
	i5Zx3vztT4kBCYtk2LXyzcfNDY0wvqalynFQ5ncnUpgfo0KgQmQN2mH501/Xb/NA37CaKWH+C6A
	PQvFD5VyLvWvRaO6ng54xtg/F6XmEVx6zsTr0dFuaue2yo3G3xY06Dm5jrDoEx0FWKaKMBiMx0S
	r+rNkGsdkgFdtriT39Z5YpNkW9lxNe2tY5lnW2e+6WnaM3yn3BBfN2GjRpCxjTLCjU1sZTcnric
	bPEoIhz/vfe4cwYwViOO0ax+Y+mfDy6H2hbggYiSNrJzlYoKrK3o9Nfbuvyvlt9cXMd4AeuAQBH
	dgmBXOfcGsdyJJfAD8WCOkCjqSrNubMJvYN00mVMpsj5s+rRVidiQpwfB3KMIKthuIwBYHCUR+5
	ZVggz/OyS3P7RtuL/KWvRQ9Bv92i0CYFqSpGmHiqnHifgpNRUJEFHchs+RX6JAQ==
X-Received: by 2002:a05:7300:1486:b0:369:d8e1:7bb6 with SMTP id 5a478bee46e88-38570e24c35mr16246805eec.25.1795455545227;
        Mon, 23 Nov 2026 09:39:05 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:39:04 -0800 (PST)
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
Subject: Re: [PATCH 26/27] Docs/admin-guide/mm/damon/usage: update for
 user_report report support
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:25 +1100
Message-Id: <179545256509.4.13115689957500135208.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-mm@kvack.org, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261121210013.130397-27-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-27-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 13:00:10 -0800 SJ Park wrote:

> Update DAMON usage document for the newly added user_report type data
> attribute report support.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
