Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447162;
	b=R7VW94jv7LPoU8CtIh0xPPSXAIMzjuNAG/yFyGo/1zRZ5zPqgkxwnLzCylghuwwXsaeO
	 Q2W+E+7jiVhGTGbRh+qso+OkSK/7/0JOAB56+RSeZIoRaeWwKtMUiD0L9XCsCDnHnQBio
	 ZWWH1Pi+2zeGFv4KmPKhF5ZdeG6jdPZc6AkmL+nmWfFdhRWDR+bjQU6LKagGk7WWPZGsF
	 mldvdY9HxGtFRdTzix62OjC+dYkUGPh75fqv6D2G0kVagMb5fgbmSIuJoF0dOSiU5wzvc
	 jlb4W0ORFDZwXG5wSOvz5pwfG/h8m+0oHBH4Q/x7YTS/rpFnVIekthrgiNUaO14BEhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447162;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nMduPgxhL05hgWVnvhGnMWz5x9v2kK38uOuZVHIkEsw=;
	b=Y52uSM+4L8/SkG502h7SzXQe3pogLYAgW5NpLATPc6j8mq+7aFvVOApOPfadHRgvPbYD
	 a9+eTvS6w7sFiWGLtQCpoPy8g/24izTHIzdWuN4ncJs+Es7k3Wb9jOhZBRp08G14gAF17
	 Mx5CdmJHD/mVJM6fp47R1Gn+sSlywp99NVaVXHZXHFaK3IQCiAGawAjHcXPyFOWeYSt8o
	 MN3GGdd9WVr+uXUL9JE0a9RHZ2f2zzZAdUJfvXOSqYiK/CuOCT3/Wy748mUxjZ6OjpVVN
	 7ZyC80qUj8yijwhKEmm95i8UL80GSuv2b8wNLSrjCenoigYEfusOMbZ9zAu3SOr+K5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODVv9AeI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16498606A32A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODVv9AeI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55AB1F000C0;
	Mon, 23 Nov 2026 15:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795447161;
	bh=nMduPgxhL05hgWVnvhGnMWz5x9v2kK38uOuZVHIkEsw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ODVv9AeI9sddSLK+goT/hmGY2znvpX3QsZyfm2tl6lwcMlrKGrY/wop+ZTkp7RQBx
	 ODWttbZA3UvraNjvx8HmP0mjVhntwkmQUxwygejO6lNV+3+XO9nJ2rBSgzwrchl/0x
	 IycdQNZKek71XDDhJgUJMmfDpFSvBDxgn6xmsqh2m7oe2hQfNcfMFi7lSPcvJTeaed
	 K8KZXfwAdsZZaafLIwxlNBUt4rqKmcu6Ccl07yyxKpzlbgW91qmmDi/Fg9KgJyxlyD
	 BEKVY1LPNWDyaUDEQyS926lszFZ5vMZTHC8NIx8Hg1KcUE8nvuvglcNlEd9p6zTifx
	 NPLwOhxvp1UZw==
Message-ID: <sashiko-outbox-229529@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 0/6] mm/damon: add sz_ops_filter_passed_last DAMOS
 stat
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261123151309.82675-1-sj@kernel.org>
References: <20261123151309.82675-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 15:19:21 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

Sashiko has reviewed this 6-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123151309.8267=
5-1-sj@kernel.org
