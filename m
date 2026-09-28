Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10065489868
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588210; cv=none; b=hNLTgK0QRwtX4RiURGaGc8WyvmoSpa7Nhb9RlhHhAR3Cedwu0LHF5SbgloMntJI6g6Yb9zmF18CU0vnCYo/ViKmOG/5RvBY11mV37hjxUHJUKZMek/cTJeEQll7JUxof1pzIh8Udd3XVjALqAcbvp4ioyL0bry5CW9J953UPI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588210; c=relaxed/simple;
	bh=bLCo5KAq60D6i2A82IgtOVVw4+1UdYApON8nroflLaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dhJs0E1kt+xNrStk5/yEZmhUMxuB+0nvNXTxoVeXAmZF5Dchsfrlop10f9ymkttsAhmXP4XaGCtd93htAzNNZh5NtU1ZIGjZA43R4mF7yuknDW71lOeZkWnKxOsAwX5kX4UsNFCeDVm9EsYROHSkrWIHfQYiwkDN58Bvha70FCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dH1F2lRR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH1F2lRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8086D1F00893;
	Mon, 28 Sep 2026 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588208;
	bh=bLCo5KAq60D6i2A82IgtOVVw4+1UdYApON8nroflLaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dH1F2lRRj5TIVZhCtFtI7PQeG4sxvMR77wj3rvlSegwT8K/edxToGkCjPGlMhl1Iz
	 1v74aTu/342lOhfezsl/05UeyqFcqEw/IxUsi5tx3mFqAJIQgY4BhEZ3IpR348fi6a
	 6+IAF12ar0+QSpW1ia38TKnZezfaKELeqmkyLCWBpW6hTjLYXGioh2bBs3AUGfKRg/
	 54HtQzjJqTVerQbzu477pECP3jqMj+PxrM8HhiVhw3BD7/t8IXZA/KzjduIuJxp86F
	 ZPYtZODLEHpFf6wyWmE7NqVJfqjiSnuxRd/E5OHIpDnYO+Uq5hHte14eWQ5wktJsNK
	 oO41CwHPKIzuw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 5/8] selftests/damon/sysfs.sh: test quota goal
 complement flag file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260928093342.16584-6-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
 <20260928093342.16584-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:36:48 +0000
Message-Id: <20260928093648.8086D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Test the existence and the valid input acceptance of the newly added
> quota goal complement flag sysfs file.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928093342.1658=
4-1-sj@kernel.org?part=3D5

