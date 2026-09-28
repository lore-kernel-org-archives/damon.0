Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D389489868
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588394; cv=none; b=OtwmpsgungeTMrDok07ipvXWIlBbz/khMAA5Haksq/1P/4akUwL/tKzYsoeYQDsNfFhuSByEHA1UbZcrQieFvmXhtF34gZ1tmTdTgsugJViy65v1lkM8uUS/u5IzTUZwqb3coL6grB2hSDxYiGIZv9yaoh2/LOBWvH8ZqFRVHTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588394; c=relaxed/simple;
	bh=v0/Y6qCe6XM8oJ9trOwI0BctZ6evRW1RqgDq694xCTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T3yZwb/fCC4eWTC80r0RQP66lWSUe6mwBpQeNSsYzTIuR7ZPIifLX2MPBFt0mObU1IIaBrN05R4wPBbkzTROf3KccPyTEgcOEEoZwox8h7404d+1C5EjkyWQDEfm6YJSvqZeDi4SwDIITCnk2ipqs3gVyUO3juHlK05klocsNkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=om/9WJJB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="om/9WJJB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFE71F000FF;
	Mon, 28 Sep 2026 09:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588392;
	bh=v0/Y6qCe6XM8oJ9trOwI0BctZ6evRW1RqgDq694xCTA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=om/9WJJB0ePmmMVIVGdMubNZEad2oS6LALzUW0BJKnhBdFDwwiytt2sMNcOwdrCZK
	 Zn0uqTe2tf5jIO4f5VxJ3HPYYv7nJC+jWvczUEESWIljgFL0gvTO2BS+vJ3QJS96p2
	 ZT1cqzs8F+OKSQkKGbc9tppDLTyKFLE6t8lZELW1KMetFUW3wOLXY+56swS0vxfhLi
	 hNJZ6DMbDONeoFg7fzBD9lEIaFWH8QsoOjkPXfVbtjd+wlouj5oXk7/OiGAMZSou+h
	 Cz5jIR+w5UG2WBtO/vJBsAXVs6PRN9Ek0bxBszINk5bR81LfAYMEWqznAGJAmWgCXx
	 7xrsIxq/SYuBA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 6/8] Docs/mm/damon/design: document damos quota
 goal complement flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260928093342.16584-7-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
 <20260928093342.16584-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:39:52 +0000
Message-Id: <20260928093952.8DFE71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added damos quota goal metric
> value complement flag.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928093342.1658=
4-1-sj@kernel.org?part=3D6

