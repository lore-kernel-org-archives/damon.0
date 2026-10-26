Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030022;
	b=pa4fbROd2WWsxp9TE72LdrUGDderxId5Bczq1K56re/bOwx6Ug7I1NrgICVmioW5rNSK
	 4rb9c7M+/vtPaE321kpoE/y5NYM8uNWW1gG0+enUgbDtdW/2K+O2X7PGtiCmbRXWZWDV5
	 KS3EqpBlzDs7yt16LwBnKdINWqPwF4FbcCorbeEP+5VJJ7r76RL6herbHuvjX3HpFDVNY
	 IamtnBHtKIquv6E9DhwMJ+wfuLUrFKMWrLsKMJRbFKBNKPC5/12A0OEESEE0Lwktl1HWS
	 mWtYt6bPctZ8txaXMnKjtwaNn6wupJjQKcyBct7mRAIe1ho4edOobB736bsivYzr9eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:Date:Message-ID;
	bh=R9AlT6hvjH3cYXCRXYi2r0iIos0zgRK9lv/Md13+/KU=;
	b=KzcRxH0cwfaHXPyh7K4XZ/Gfl9oOteDsxhulEqxd4w3rEQHyPEuXMyZN07Oftw+UN8xS
	 5DrNfCb5MoWTEnHjKzWglRu7SF30du0U06CMmKCiIQ5Q8osx5ZKABQqbT396QqQuG/Bhk
	 0FFgCjcMtTJLpFSUNT57AlUwsd/wcSKqzfFt5el7zMn/YAumDeIJrDWyjS42ss02y3EUf
	 o5km3+QHbRyFYI1IhMZel1gRBfvs8svvUDzNZ1E+VR1iMV+bAGcPdNa/JbWOZK1Af0/sK
	 ugyPq3gVeu8Qqu0ryuMV16m/EEyAlDYK650qJ6faHxtg2XPqVyXpy63X4FTgzCljLIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZK+eMRyP;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED45606A31B
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 15:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ED45606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZK+eMRyP
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2e96be2196bso10569275ad.1
        for <damon@lists.linux.dev>; Mon, 26 Oct 2026 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793030022; x=1793634822; darn=lists.linux.dev;
        h=message-id:date:mime-version:content-transfer-encoding:content-type
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R9AlT6hvjH3cYXCRXYi2r0iIos0zgRK9lv/Md13+/KU=;
        b=ZK+eMRyPoe5p5Pzm/sFXwwSGLrBrophcaDUERmrQt8RkAgNNIj4FKOvobhLtopIONO
         mD6RFlVBga5YUFo50pDjBwDXYuUcStnqPzZ5/Xy8OZtGA/spFH7rLHFMCCSYFQrX0T1/
         tz2RLvY06f392NJzKEly3Z24GBmPqOvW616OiR9v8r5b9w8peohVy+/EkGazDbqpHZnP
         MAFlZIFwXOYhO3Vh+Qty8w7errWqEW2caX5gbkPTjPhk+1kmSI7ifeZ2YzH8KWiVzivf
         ebr1xSz1muALa8D8pYERBgYYtOf8X2xcMGpuF8pTeFGGFng/pZ5fZ+ui5yDM+8CUffsk
         eUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030022; x=1793634822;
        h=message-id:date:mime-version:content-transfer-encoding:content-type
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9AlT6hvjH3cYXCRXYi2r0iIos0zgRK9lv/Md13+/KU=;
        b=FIbmofadolpDoktzo17APoL5z76a2NjP/vMVbYZO/xviMaolGRZXvEnfZ1BlJLdIBg
         KTzlFwMy3C+veXkdotGxUyA8DHiYciuxGrcfcU/Lpc1MmvmfNNozp76BI0iP5vw8NeQb
         JK0jnuD3VTItdEwCGm5oOwFWnyRoJV34HozLdnv/WBchKFs/AP3FmUBdSDYf1lUrozZ6
         OhR2PXVeF6gNhPLv5J+NBMZNEfFqvEE6i/0DZx1PKoJSNmIzLUMEUjqMzdaV7xA+Mscu
         gLL7zTheg+JxMuH9CAq3L8w40woal9vX60L6SV8nx65qeIORFbPbw2l4/86WpmODFVlD
         VrNQ==
X-Forwarded-Encrypted: i=1; AKwUvBwhF2L+SW7V20bpjJuco5A/erP1DL1w8Gp1biUiVeSKVYCzVXRUjE54YKIEUWjByU8YZ3lavw==@lists.linux.dev
X-Gm-Message-State: AFq9FYK7WPLvuSJGWf9VtuPy7MwsMTIaq5mP30TlwXAkRJWD8FtzeTvK
	CFRtoLf895s4h0CeD/XMleHt1yqPk9DStddy6S1z68J5TbUg94B9d0Ae
X-Gm-Gg: AYBFou0vgz3324nl4nf4S5SpcbBCp3Zvr6TumhYLO2wlfe9f42lMSkIw01bZQqUKj0a
	gqONLvgAOwC68msSgGh3Mh+eBuGdmUhFI1/v7iwn8ZXBAJItVFqvd1RY/SIBAQdXhDf/yI3MBmW
	7Dp4GbTS7Gex49djuoDIY8bDj9MZJ9o+i90r1EDtyaega0Q7LcHSJcF4HFnafQJdL9xsR60vPJT
	DPEvKzmJFSGuQu6jgNg29a3NIIc8wBWTVKp1b2p2I5SrlMsYkNnhmHiQ3J0/XwOUCJbfG4Hyrgy
	RrmkkH4ce8wxO7ev/Q+vwuDxfNK8qNsu6XbhBuJ0e7D489ftkPTndWN9/JAt/zKMVUltv6+8/Vq
	qxwmccVlAo31Q/6Z1t/cd5zgUKEwcM4Vpqu4MXyOhm4+SwVwk/4gn8xmxBHqay827g8BADzazRs
	Ju8y5/xXmjowgqSNIQknDxcTqc267cyVrWbMGhcTAT/qVtDWtveHT7lJu3nEAg/AOcuwrH+7kp6
	URxzEYnbsoO7hq3E1JzaOR6hurBX9k8zw1OmLW4MRMtNnZBbmXbvw35fpcCR7BpOgRHGhExtCLH
	uZllE2W3KzD1syjGaSK/pagiWTzR7H5eAP2B3mAyhJo0/3OFpVK7+aks+B0k2BXUwEQSBS9FEA=
	=
X-Received: by 2002:a17:902:ecc9:b0:2e6:c39:b25b with SMTP id d9443c01a7336-2ea9c6c835cmr57333975ad.14.1793030021722;
        Mon, 26 Oct 2026 08:53:41 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b120095sm19328195ad.16.2026.10.26.08.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:53:41 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] Docs/admin-guide/mm/damon/stat: fix pronoun agreement
In-Reply-To: <20261026143109.150059-1-sj@kernel.org>
References: <203ef50d11ae600ab06546d73a2290f291381551.camel@mailbox.org>
 <20261026143109.150059-1-sj@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Date: Tue, 27 Oct 2026 02:50:54 +1100
Message-ID: <179302985414.2.4645643321689632441.damon-docs-reply-02-stat@gmail.com>

Hi SJ and Manuel,

On Mon, 26 Oct 2026 07:31:07 -0700, SJ Park wrote:

> Thanks.  Unless Aveline objects or add this part to the next revision of
> this patch, I will add this  when I apply this patch to damon/next.

Using "to" reads better to me too. Please fold Manuel's change in when
applying :)

Thanks for the reviews,
Aveline Noir
