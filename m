Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.161
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018707;
	b=BhfnnbwtYaY4Q4uNxSWeC03VHPx/YL3AlGLI2pBPcggvfB4UtxMxZgsGiP6gDrrgGtEw
	 PMTO7exs6RWroAmClit9cRTretLq5mi8AIBaxR8rqmOqepq1cPuXWKYC1aVk+xYhd1pmC
	 U1f3MMpO/7oQKMgUR7fbYI8h8rPt4ykWdlbTjMiW8R2+6X5lKPeiXYKRLoLzWcsWKoaOG
	 lu0BYsYlzpEfVBZ2JdbpiHRJAaxli6b+JjNmrV48pKygpKA/boKIYP3XbvZ1wIqFsK+/r
	 nxz82MoL0AoquWR8+9KXs5bktL4Hm6xDZLQnhqAEfrFva8cJVZ0JNGGaCDxybcRQwwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018707;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-MBO-RS-META:X-MBO-RS-ID;
	bh=gNSvfMB+KSu6h3D0gLvM2K+YtllhQPeCS/Txg2cf7IA=;
	b=1l/CCZSUXLO0iMX69MW0ugTaf4obBNe3Q+KJ2YeJuSFfNNZA2qRgPVwQnplpmCwuh9JL
	 +xTlSvXsO0vaI4eXbUo2A8VIcKMD/a+D29ZgNejOJkZdGjKFT3xNpHKUW5ftuxVTQQLdn
	 SukkM23BYWhljWdLJh3Q9A84S0rLEaphiLgPz0o8/htsRvAgcu4kxk95yJ4JEjkpw7W38
	 RuGtBGvLDZ/r7miMg1xzVJB30Sxuk+e53NuFuxDgVnbTHwvGlfv6Zl2JAVhUTiz0jqSBp
	 YbjMCFQ+0MHSK1aqvF6vyUvkvm1H5YKog5Y+MrAShXBKNOVTdTgq6QjAUq7oql9wMAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=tYzOSWiM;
	arc=none smtp.remote-ip=80.241.56.161
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A83606A31F
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 12:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81A83606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=tYzOSWiM
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jCtcn62WTzKm5M;
	Mon, 26 Oct 2026 13:44:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793018697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNSvfMB+KSu6h3D0gLvM2K+YtllhQPeCS/Txg2cf7IA=;
	b=tYzOSWiMgAO6iqMmGbzPgi7ambZF9u29A0182Egf/5Y8KqLX/99xqmrfu+u0IIVVZtVU6w
	YNU3sj7Q11Xdyq6RU6XsdvmYlmAn8uwxk5YKI0J+CLEO2Yv6t231xxmAXWJAMQK//DxFCz
	c/kvG6zon4JtTiOX22JjdxDJiH7mN19P+65Y1AAFqK7DjGuqBSNrAB54f+SOpXBrufwfOK
	GZzlmCCcsdj+QxmIR+i6V8RWzl7FNa+PPnQZ2OXfy81KLTc+y72RVBCGyF6YbD79J3MZO+
	Fk4jtdS3iAhHL29UUmHx0Smk8Q1Lwse2FLBYu1vXJYkJc3RWfyjOcLXQ0pX/cQ==
Message-ID: <203ef50d11ae600ab06546d73a2290f291381551.camel@mailbox.org>
Subject: Re: [PATCH 2/8] Docs/admin-guide/mm/damon/stat: fix pronoun
 agreement
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Aveline Noir <jm5905938@gmail.com>, SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Randy Dunlap <rdunlap@infradead.org>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 13:44:55 +0100
In-Reply-To: <179301327249.2.17530814278215474568.damon-docs-grammar-2@gmail.com>
References: 
	<179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>
	 <179301327249.2.17530814278215474568.damon-docs-grammar-2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-META: mkyds7qstpeqe1s9cnddd6e1xznqfuib
X-MBO-RS-ID: 34eaf3e72545e878961

Hi Aveline,

On Mon, 2026-10-26 at 22:14 +1100, Aveline Noir wrote:
> "converts it" refers to the access events, so I think it should be
> "them".=C2=A0 Rewrap the paragraph while at it.
>=20
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> ---
> =C2=A0Documentation/admin-guide/mm/damon/stat.rst | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/=
admin-guide/mm/damon/stat.rst
> index 4a9db755a526..a93609649a5f 100644
> --- a/Documentation/admin-guide/mm/damon/stat.rst
> +++ b/Documentation/admin-guide/mm/damon/stat.rst

Here I found this one:
@@ -41,8 +41,8 @@ enabled
=20
 Enable or disable DAMON_STAT.
=20
-You can enable DAMON_STAT by setting the value of this parameter as ``Y``.
-Setting it as ``N`` disables DAMON_STAT.  The default value is set by
+You can enable DAMON_STAT by setting the value of this parameter to ``Y``.
+Setting it to ``N`` disables DAMON_STAT.  The default value is set by
 ``CONFIG_DAMON_STAT_ENABLED_DEFAULT`` build config option.
=20
> @@ -68,10 +68,10 @@ estimated_memory_bandwidth
> =C2=A0Estimated memory bandwidth consumption (bytes per second) of the sy=
stem.
> =C2=A0
> =C2=A0DAMON_STAT reads observed access events on the current DAMON result=
s snapshot
> -and converts it to memory bandwidth consumption estimation in bytes per =
second.
> -The resulting metric is exposed to user via this read-only parameter.=C2=
=A0 Because
> -DAMON uses sampling, this is only an estimation of the access intensity =
rather
> -than accurate memory bandwidth.
> +and converts them to memory bandwidth consumption estimation in bytes pe=
r
> +second.=C2=A0 The resulting metric is exposed to user via this read-only=
 parameter.
> +Because DAMON uses sampling, this is only an estimation of the access in=
tensity
> +rather than accurate memory bandwidth.
> =C2=A0
> =C2=A0memory_idle_ms_percentiles
> =C2=A0--------------------------


Thanks,
Reviewed-by: Manuel Ebner <manuelebnerli@mailbox.org>
