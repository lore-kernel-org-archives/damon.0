Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155215;
	b=WP3rn6sRt1hYEqussOFryMi6il6BDUw7fQn6zTzIio9O+go9aBlw7e70fwL5PelUmYVl
	 rRhBeeqeCah79j1cjgtd9BHGbn/0um07oKRwaPzJgyh3OpXR5C01DOi3L3q4XbEAW3zUu
	 Xo4C52TIljCn7StcxQvLRIrZ9rdf5/BRaCZgyXurvcTXF3XdAYFrssxZOicxLmVDE245/
	 7b9zZCIahIPeW2k4Hyz+JP4HwYPE0+VW5HRaUlE6aTZxhwQIHhVeBdZLn0nwBqOTPixKQ
	 eGGf5hqEoBkpZKmfmt/DYaIU3IRaZlgnDEHCVP5cbv58ju2RpHnPkJRMmljJS+Uu0iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155215;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rfsSxZFEpYdiQSJM1kyGKBxdeeRxyNkdzgufWtZByCU=;
	b=TDOwy1k7iDFDVO7VEZH47c6asZf1bq7wNgQhg6EkROaSIcAYSz1PKjZUJ/jJT8C5Uyoe
	 K1eZ7kITcZyku08eNlHP5XODVmEjE+sGLKJ48YxPysiZ/YTaKH6kxMi6KKQ24eK3alW2B
	 CffuE8l4YBAx3GJieu9PTrbX9XfNgpnHT4slS5jSA/vnfctkgzg5cMpOKvmOP9YoSYHp+
	 JYUd5G7hm4Tp54P1kCLuOAsTNcjooQzvhESbPQBLvra2z9TBbgJY+t/kz7s8Y7MotDYtp
	 T8B4vVdtI3bvlAJMd+wurTGAsQ+TokIaTD8aCOXKeXGIHDgifqN6d32COCN4efLwzUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWXG1DMW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B817C606A51E
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWXG1DMW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3356E1F000C6;
	Fri, 20 Nov 2026 06:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795155215;
	bh=rfsSxZFEpYdiQSJM1kyGKBxdeeRxyNkdzgufWtZByCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WWXG1DMW6DEh/XaUOB67M9aKrpiw7Ssi5Qq8k3b6Pd0MtEhXXSoh7ESrqBNUftMuc
	 8EI6MpSxN/uapi1O+1LTSxeb51Tu8NcleTejt36tTiSKwvpDDRMctdV3ElWxW6Nusq
	 8cQ6878YOP75v6QjBp2qAoHpeBsFBVHqkO2/cSYWZyE+bocIjHCDCqDwq5sfvCY5tr
	 50nhxRD8DAPPzufzq2nTxzwPbnnWfSJGwAmZDYNoiDvdBG0iTGNW1inRDJM7zC+3KO
	 RH6daeA/DTObSc/jW6U9aN66D48Q/KkOvAnwJ6EqpVnzXM0jjTqCiqBcgHllwdLjDj
	 II76PsieOyN5A==
Message-ID: <sashiko-outbox-224543@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/4] mm/damon/reclaim: set memory PSI 0.05% as
 default quota goal
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120060741.92121-3-sj@kernel.org>
References: <20261120060741.92121-1-sj@kernel.org>
 <20261120060741.92121-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 06:13:34 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMON_RECLAIM provides a PSI-driven quota auto-tuning feature.  Because
> of the DAMOS quota internal access pattern based region prioritization,
> it means the coldness threshold (min_age) is also auto-tuned.  It is
> tuned off by default, though.  The feature is expected to be only better
> to be enabled.  Enable it by default.  Set 0.5 milliseconds per second
> (0.5%) as the default auto-tuning target memory pressure ratio.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120060741.9212=
1-1-sj@kernel.org?part=3D2

