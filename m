Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5F4A1DFD
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483643; cv=none; b=gLl8wKxNx+WjsLJ9pPFsBg+/wgopTWM9JXsforppRee6Od7FYu7MbfQ7vKkAFbaBn5Q3IGlvYiobYp0TKOUNgAq4aguCKKdpbcsvvqmSqymKQW67fgdTUUUjX9g/lKIB9e93iEn89oo2lRGJR614whDzUMkXXRcv7RzOYZPsiK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483643; c=relaxed/simple;
	bh=wj3LRGexbU+Rp9l9ababeKkMZ1s5S5osMtuXD8FCNuw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nb9DwBF31SiHxJxdrlsEpIEtAmSONZv3+UpvsqOKwiZmWbkYSyzKRA/Z8598Sx9o0ZObRa8ctsIzkmSoD6Q6jAicsq7rH3i1AMYplyg8N6rM6nFzImbSmU/R6DW7KkcvPzmwjXuSOxSQl2z+i6ZlGvzKNjfVwPp3QWtogHGqcVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLUr9An9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLUr9An9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEF51F000FF;
	Tue, 15 Sep 2026 14:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789483641;
	bh=wj3LRGexbU+Rp9l9ababeKkMZ1s5S5osMtuXD8FCNuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SLUr9An91rk3wmOoXPnr4xk3P4p9lQwpa0rXwPrbGinBI5xbqG/TqHTPi5dXAqoi6
	 sDCsQ8jOodn1XHtSCLzyWT/JnZImpuduAjL9FAt5JGwy1cOkB1as23oMQpqQumgnnS
	 LmyIqWYI2S6IY09/xayM/69LQmtsBQOQq/tsYqJAW0W3Kfne3x1beIJSRQz4tB/c5u
	 CwTcPUZHorOv+TPEOwq9xWDFQld7KldC1NPqofgZBaScF41c7B7N7G3BZn87xciGKc
	 DoyFxgeb0y2C20hHe1szXOw5JbOC+WcRVNtCHLxNJHarOBW4HsNrRaHfn190WgMQu/
	 xGbQT6v8cKdKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] mm/damon/ops-common: support hugepage_size damon
 filter matching
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915143359.91472-4-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
 <20260915143359.91472-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 14:47:21 +0000
Message-Id: <20260915144721.7AEF51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update ops-common data attribute filter matching logic to support
> hugepage_size filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915143359.9147=
2-1-sj@kernel.org?part=3D3

