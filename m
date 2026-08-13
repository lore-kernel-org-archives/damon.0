Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF05340D9D
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786600382; cv=none; b=fIUkxBvhFkOMzceZxnIN0uiexVDVRerHmVaiYDLd5c5iAkWNmhhcpF5IpZoG9Ei+T7qovMAC8OMU9rwOxmlHtlfAn9TWeBQMFdDqNNJ+wL74hEb98AemC1ss3lT1o6W36UM26cvDNK3wXt23J2/Ea79sC4irQs3W27h8xX0A99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786600382; c=relaxed/simple;
	bh=i2pbSIB5P/Sf9eQTUHT+PT+7kQWYNUYl5HnHtxZ+wxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fHYPDCls4/HI+LWSNKE/DiC8oxF56Vfa0YgGr9rids+H8zO8xM22+PXz74HskLuyEdmDvIrUcIWmjvLGeRQhPztrwTkniWiluzxiNctzQgfXwa6f8LArwbdB3ziZj8SMjUGz39Mq59sZfbNMD960jN5PxXV917UU8Aq33Dn301Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEK5yF81; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEK5yF81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A56F1F000E9;
	Thu, 13 Aug 2026 05:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786600381;
	bh=4dXa21dVtq3Wa5LW2tUTjt8dgQ2sixfmmeT28qQ6lpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TEK5yF81jY9v/wrsCIx/lxk3MIoNJbRkdtoGmsgVpxlbK1mtfeTKsQvP1GJjVg5aM
	 HR//XAkRd32++EO/pUgDQk8eWLt5n744WKIiNLUFCQVgOAezl+GApI0ordmoi4yuol
	 79xOUtXg3Ap7JnXZXKz+WbIEx+zNroYC7rcypb//YBMgHnGMd9ka1oomNa/6R7FCSC
	 CKqgoFySTqaV5hHb2qRB0MtDA+Qan3lfRnR8wTs/mvkzuSLCLw4rfwfJe8OpUHfJAx
	 pDW80yvpcfreVa5NgG8Ljuzn1xN05z1TxTMxBy0qvOVJszcBqAwiO4+K1vq3TQfD0Z
	 oebsHd8JuoU2A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/3] Revert "mm/damon/lru_sort: error out for >10000
 active_mem_bp"
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260813054432.101197-3-sj@kernel.org>
References: <20260813054432.101197-1-sj@kernel.org>
 <20260813054432.101197-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 05:53:00 +0000
Message-Id: <20260813055301.4A56F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> This reverts commit 06befa61c427e74319781e6f35a364cfc32dbae8.
>=20
> The commit was made to avoid zero damos quota goal target value, because
> it can trigger division-by-zero.  Now the core layer handles the corner
> case.  It returns an error for any attempt setting the aero
> target_value.  The corner case handling in DAMON_LRU_SORT is hence no
> more needed.  Remove it.
>=20
> Note that this slightly changes the user behavior.  It still disallows
> active_mem_bp of 10,002.  But now it allows other >10,000 active_mem_bp
> values. Setting >10,000 active_mem_bp makes not much sense.  But it
> doesn't cause critical problems such as memory leak or crash, either.
> Arguably that doesn't deserve additional code complexity.  Just allow
> it.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813054432.1011=
97-1-sj@kernel.org?part=3D2

