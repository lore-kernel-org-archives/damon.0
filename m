Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019476;
	b=0kzEyHinyHrfTgbEnXVIQXIUjo1FlYeuPWut0yNpMF9TwhQk0HkHbPPTnPx/oLdP68K+
	 /v3MKzf7ppnn7dtFPWR3HbOIa2iwEI6wCM9/slgX9gxLE2P/lTQyXquvQ3VrIXsO+huLU
	 P3SfL1WVGvt2VGddjD8dySCv5XCQ6NfyVWhISYKhykfhaV1R07iZtZZ5N+uRUH6jqjURt
	 s65KE/RU3CVvit+GgwEPXfTa11fZGOylNUarNRLuJnkQl6GSnF2pxqb6ZfkaeK++NKDWr
	 vMd21HpV38sczx3OhZ3yW1LZxgKRs7c1Cqw0T9ixq548vK0y+mvdERIQi6y9lwZm8BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019476;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-MBO-RS-META:X-MBO-RS-ID;
	bh=kZI3MT1fgSFZtZ0NsU7CZ4YdGhUuoHZE2FDP+AhJ0Qk=;
	b=H4unoyYOtT+ulrzLz7dTu/rd28A7oETkSQmz0ncLzouvKxDnHXw0V0Aup1XGNq1TZg04
	 1skzTQ8vSCpiAlMATPm+hDT7pyYDLGAgDlVE/d0TL+fObU6FwrI76x2bpZKH0Cu+4MvUs
	 Yxo/ia4DB2HQWbayyTz7ZOVr0eumozZkWOaPRXmDBoAW/ml1Rj5DCGoWJC2Tli6UDJHWW
	 Kio03eLZiu7FkAtIyp/FsJRlsWyTbXygY0zOP1y5urhVFuBTaGJv5FqIPUlI4sNbBDpjG
	 c6DNAyOCcE1dgWMHzjPQTrXGuDyQG1gIXhwAtGKfHcVu5MamLf2lDToDAakUfvCVNew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=FCJOn1u+;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C007606A31B
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 12:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C007606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=FCJOn1u+
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jCtvg6Pv6zKnCH;
	Mon, 26 Oct 2026 13:57:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793019471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZI3MT1fgSFZtZ0NsU7CZ4YdGhUuoHZE2FDP+AhJ0Qk=;
	b=FCJOn1u+/3qCGOcdCmyWy6c3EnJJbMA7p+5O/jZIFJVDNl1nGPzgOOVLBR640V8uM6B4cg
	zZ/Pd2cWtaHFlZ2pzYBrz6T8KveM3Ja4nPS1wx3z4Wn8ndDqGTKe5L/mql743iB0WWg8lX
	HHAQLFQCKkrwRu0z/ka2d+4N+34Sh3RcPoZd9cF1GK069gPmtg42dz5bpiLp1RqXhxfrZB
	FIDbd/IYVmY3xvi/CNqOTra5g/Fn9Sa8sxo8fcx+OvMjmzwY8p7tLWhCZXYIroA5v5p+kn
	lDyEXt0TiCcLdn8DJdli6UFmFLuwBeO6MNGSyJIOgLiWhB2msBOouLoOYzOUXQ==
Message-ID: <d054b7a2653a2ff3d419b689a50a53290c2cafbb.camel@mailbox.org>
Subject: Re: [PATCH 4/8] Docs/admin-guide/mm/damon/lru_sort: fix remaining
 grammar
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: Aveline Noir <jm5905938@gmail.com>, SJ Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Randy Dunlap <rdunlap@infradead.org>,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 13:57:49 +0100
In-Reply-To: <179301327249.2.16817896016779044743.damon-docs-grammar-4@gmail.com>
References: 
	<179301327249.2.4690198998605536207.damon-docs-grammar-0@gmail.com>
	 <179301327249.2.16817896016779044743.damon-docs-grammar-4@gmail.com>
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
X-MBO-RS-META: nzgmngh1z81sf44u537fisxxmnjw44kz
X-MBO-RS-ID: c5f618f06e0dfd708bf

Hi again,

On Mon, 2026-10-26 at 22:14 +1100, Aveline Noir wrote:
> Manuel's recent grammar fix for this file, now in damon/next, covered a
> good part of it.=C2=A0 This should take care of the few mistakes that are
> left, like "should automatically activated" and "Make DAMON_LRU_SORT
> reads".=C2=A0 Rewrap where the lines got too long.
>=20
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> ---
> =C2=A0.../admin-guide/mm/damon/lru_sort.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 45 ++++++++++---------
> =C2=A01 file changed, 23 insertions(+), 22 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentat=
ion/admin-guide/mm/damon/lru_sort.rst
> index aa4cc90ca57c..c628e3f6e587 100644
> --- a/Documentation/admin-guide/mm/damon/lru_sort.rst
> +++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
> @@ -35,7 +35,7 @@ deprioritizing cold pages on their LRU-lists.=C2=A0 To =
avoid it consuming too much
> =C2=A0CPU for the prioritizations, a CPU time usage limit can be configur=
ed.=C2=A0 Under
> =C2=A0the limit, it prioritizes and deprioritizes more hot and cold pages=
 first,
> =C2=A0respectively.=C2=A0 System administrators can also configure under =
what situation
> -this scheme should automatically activated and deactivated with three me=
mory
> +this scheme should be automatically activated and deactivated with three=
 memory

Yours isn't wrong but I would make it:
+this scheme should automatically be activated and deactivated with three m=
emory

Choose as you like.

> =C2=A0pressure watermarks.
> =C2=A0
> =C2=A0Its default parameters for hotness/coldness thresholds and CPU quot=
a limit are
> @@ -55,7 +55,7 @@ DAMON_LRU_SORT utilizes module parameters.=C2=A0 That i=
s, you can put
> =C2=A0``damon_lru_sort.<parameter>=3D<value>`` on the kernel boot command=
 line or write
> =C2=A0proper values to ``/sys/module/damon_lru_sort/parameters/<parameter=
>`` files.
> =C2=A0
> -Below are the description of each parameter.
> +Below is the description of each parameter.

My choice :=20
+Below are the descriptions of each parameter.


> =C2=A0...
Looks good to me.

>=20
> =C2=A0--------------------
> @@ -310,7 +311,7 @@ Total bytes of hot memory regions that were successfu=
lly LRU-sorted.
> =C2=A0nr_hot_quota_exceeds
> =C2=A0--------------------
> =C2=A0
> -Number of times that the time quota limit for hot regions have exceeded.
> +Number of times that the time quota limit for hot regions has been excee=
ded.

I would go for this, but I'm not sure:
+Number of times that the time quota limit for hot regions have been exceed=
ed.

Number of times that ... have been exceeded.

Thanks,
Reviewed-by: Manuel Ebner <manuelebnerli@mailbox.org>

> =C2=A0...
