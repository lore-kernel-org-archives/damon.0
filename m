Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD736194D
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269694; cv=none; b=eT8uikgjslyEAVYHpOLX89nhGbAk3vqxziOzLq3JgibIFEVNTMdOyeejhJCI4/Oyjw9bCGsezNKrCY6LJuQArZZCiYzcwj7cOBhkejoZG232u4y9kZPw0Utg0kgErUJbWeB5PsI8GFApOwpA6jKynvv9oDwdvqU3f/gCd7AprKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269694; c=relaxed/simple;
	bh=xGXoOg14BbmO0kVU9c4yZfEL96xgCi2SBKTYnkuZbu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LvfE6m3EyA+lbrwLtE5KzFWFSs87I5eVaQSGbsPqn3C/0kV31Qx4cCWp6HV3y10k4TXR7ffMXOscQejsnWQrzBmASwmPutkLMsEPDB4wsX5fCogiW7yaZoRibV6OC2p1nG7sZu/09cIpt+ZUTHhUNuBbXLBZGxB+ulWlQhjOtg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP4YuiD/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP4YuiD/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65891F000E9;
	Tue,  1 Sep 2026 13:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269692;
	bh=0FL++EzotxBtM4aH64vyQuOCNfkwPwAmyvea1DJRvfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NP4YuiD/8plmJMXT2lSryqXfgIfm2tbG3ecEkax9hsdQnd3q5rouTUrOjCcK6qJZK
	 1PFZjT8DgjM2rm9R5KEp045pIMZTfzGdor9qOxaWCxghZ6/zzCJyN8xF1ryeYDkxiT
	 278rMO0HScl94dEQ0Hk9/gLRy5RHLqT5sdzt4F5TOvPWHBitS6mCiO38sDhhwzfAuZ
	 NA2dtR42kcRriIA7UW5YbYLILO/rd91ecxNHzmkRQ5v+n1x3zRF+/qnOdAKh2UvBR9
	 L4NS28gGZ9JoahMMt9PUYac2N09z1KbpYsEqsqDPuwlsGx0AF7NPUYpZV3NkoqYhgD
	 tvo64SZ8DstHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 09/17] mm/damon/sysfs: implement preps directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-10-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:34:52 +0000
Message-Id: <20260901133452.B65891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Implement a sysfs directory named 'preps' under the probe directory.  It
> will be evolved to be used for specifying probe preps.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D9

