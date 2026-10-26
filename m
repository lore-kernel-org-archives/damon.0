Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030071;
	b=htqWru0uzMjVU0P64O2aIDYGBDtPO2dkWR+wxS7tAQNB/1wKXk2NKfIqothBL0rirl0C
	 M9emMYIfQJFbJjyxKxRtPvXQL4rZmJTi8sT8L3y6BR32ZfU2sImMlBiSMVu0/1LdbuWcW
	 CMNXK66GEHatub5kP+jfrqSdxbbfjgjO/px3qqMvz2Gt/Z3YjNDTYOkoZ1FPuaW+jFtIT
	 YX3un/KSvBTeFigvNTIU+48OQUODY7ilwo2JlKo0w4l03OpdlORd0NX0b1TuYuYKSfUZ7
	 ccxToEpweNFBt8+K/uy+wqW5WVklJsY5zctunJcO+Iy+8HrUr9PzlJXlJbQ9MT/Mhng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:Date:Message-ID;
	bh=B8FTqo2cthF1N8/EPSwd5W+NmZQX4EUuEeAqIs6bJK8=;
	b=dnJ90+/1exC4kLIlzo2sBKeu218bTfl2Ve+GFQPCwB2iF2yRl6GOyzZuHf03VCgfyV1X
	 h+Cb+FcjssjKzxrWwiuiOf9exdURMt87R7LHWIhss9cPTOTLT8YYke3oLBwJGlkH16uia
	 6GWkv0FvS1y2qVEiweRhaXGl8QNqhaXtMy4LmZWqeOOWczQrUr0IlXWEpiNfER9Zw6c+7
	 1iqc1DqWrxvpHaHj3C+YcQBUqrSOKOko4R+l2lOhOr3jOaq+mUdpvZdENl3lStV3t5UlE
	 oC6ubnlPejo+DMl4HtsedI3XuGtuh9goC57laP7eKIHqsGOwKJBHrGs2mWuuu+vQENg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N4psmp0o;
	arc=none smtp.remote-ip=74.125.227.139
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E682606A31F
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 15:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E682606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N4psmp0o
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2ea993271f2so10687515ad.0
        for <damon@lists.linux.dev>; Mon, 26 Oct 2026 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793030071; x=1793634871; darn=lists.linux.dev;
        h=message-id:date:mime-version:content-transfer-encoding:content-type
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B8FTqo2cthF1N8/EPSwd5W+NmZQX4EUuEeAqIs6bJK8=;
        b=N4psmp0oTWaB4A0GkRU5qgXCAfs7t/35dlgApBibLUmWf9s9tkpHCGaT00z3pL8niY
         jqao3dqF0ndXd0T2nyQezP0U3c79M7Z2jqg+ofUeWfpAWK8Xg4i0qbtH2YVIWQKd9ZDq
         vwxEL0HCEJEotlG1+nR+8vFuAqXyTU2LatumUKWgEtC9FTsUZC9HFuRuyODk+uU6fbsK
         MqeNMnYkeqQeBSwmJnlsQsJUlWdbrvXL6bLx95nGW8W199pXm39TMlvRB74dhBPulokT
         wVMHHEMdN6QT76hYpXZFi/k/BBGda76quDwg+FkS4mVN4SaT8VK1LxLC/+OyyRqL44Kn
         RM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030071; x=1793634871;
        h=message-id:date:mime-version:content-transfer-encoding:content-type
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B8FTqo2cthF1N8/EPSwd5W+NmZQX4EUuEeAqIs6bJK8=;
        b=lmxzaJEhHe4Sbqmqlqa2nAzksr7J/KE3ofn6zQwbW9n+o2Pc1VtXCFzMllmPK4Caaw
         +Xzrmja9S9qk20jqMseV/Hc8Yz1/f/W8lzvGj3WBhIE2bYlyADqBLk2GsbFVIGrT0v1K
         RgzKrMYdGoXLIFeyUlB5P5/BDbiQTj7qEKQx9j1BziinTPGckurv/fnBIER69Oybnfch
         Xd5iYYKeiBjcUhizFPmIGCUuIMZbNbjMrBArcGyJTz4HbzHLxktJyvGINv9n4x5iQLZ4
         G0mqhyz/dRdDFHsIsSVpiDloSV+tANyw7WEBo/xkK+hxY4qdaLZZTXZpN2wlECprgIiu
         Pcow==
X-Forwarded-Encrypted: i=1; AKwUvBzE2lFsT+VgkhmNesDU22XUHkLKJpn+MyxKU2v1ubG7iEL702yUET+HoGCNlWxZPYQ86Ne7vQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKy5tMW201292U79IrUzsPdN7LE0grAkkpBjWvw3c5crZK7oZMz
	YQcGj0xei9ZQxKWDC32Qk3DrVHPmddy7JhgTY7aDsB7OPvP9HTp1YP34
X-Gm-Gg: AYBFou3LU/yGPlfh1bnd57kW6vIlUL4113EdN+6E04YAMwl/9kN38MyJwmPc3O5KpRK
	Lh8Xe8+cPj+mnvl6+cVg1DUQxsVmuBP9hHmT2YgBqatFVHj3qZlXZL+Ad72UcgxdS87kUCR2RRn
	WQKaNA/MvR51NxXyZ62AKBwyvaCfrATRP0kfP+QZ7QGOmXkh4HUEMxurPzdveBc0wfIqWgGBHOY
	8uPLKvimQ45fLXzF1d8J2NFo9pLiBD1J7tfEpqLu+ovsYhiSkuxIb8m/dszdv7nozlMrjYrKNFQ
	0WE9aElkM3rqX7T0G3sx5lc2DC5RWqVA7+pxT0RnAyRl20J4klceol+JxOGUbVR9i4JNkLjOS/M
	s68E7HYEX2L3LNTqxwCoQTZtWycCY8eaBI2nxbpNHvrLIieiwW31kz1FzdpTnLR4JmtgIznHd6n
	PjPg/rs4UAkemzoTvm98Wobq7w7vEc/hcALkTsYwnfwjHHpPFrgDqhCGVrgH0Rub6COjH8WGcaj
	xpUcrRNb4vV1xEQjoe/CL1GE0kh1TW2VgYyefoloHvnpFIJR6wgZz0EzO4FyfqHam+U3kirOvmi
	kbTlPHX/Jnr6HGRc2eksER3YDU6eAUvDcT/bk/Refd40jH9jws4V
X-Received: by 2002:a17:903:988:b0:2e9:5059:4477 with SMTP id d9443c01a7336-2ea9c6c82f1mr52579075ad.23.1793030070524;
        Mon, 26 Oct 2026 08:54:30 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b221101sm19099555ad.71.2026.10.26.08.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:54:30 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 4/8] Docs/admin-guide/mm/damon/lru_sort: fix remaining grammar
In-Reply-To: <20261026144451.150560-1-sj@kernel.org>
References: <d054b7a2653a2ff3d419b689a50a53290c2cafbb.camel@mailbox.org>
 <20261026144451.150560-1-sj@kernel.org>
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
Message-ID: <179302985414.2.11997096580844017569.damon-docs-reply-04-lru-sort@gmail.com>

Hi SJ and Manuel,

On Mon, 26 Oct 2026 07:44:50 -0700, SJ Park wrote:

> > Yours isn't wrong but I would make it:
> > +this scheme should automatically be activated and deactivated with three memory
> >
> > Choose as you like.

I feel my wording reads a little better here, so I might lean towards
keeping it.

> > My choice :
> > +Below are the descriptions of each parameter.

Agreed. The plural "descriptions" reads better here.

> > I would go for this, but I'm not sure:
> > +Number of times that the time quota limit for hot regions have been exceeded.
>
> I have no strong opinion.  Aveline, let me know if you have some.

I think "has been exceeded" fits here, since the subject is the
singular "time quota limit". The same applies to cold regions.

Thanks for the reviews :)
Aveline Noir
