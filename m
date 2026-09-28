Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F835C1B1
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588236; cv=none; b=kv9vAxe9xL7L/8iCNtVR2Q4l6F3sZCmU3wrXJ3J7I+9Eal8ARBLwMo+1Uhhe1i8p9KPkbErZH3TixII3ck0TCr+/NDLVlQIRWe5jYefv1BWFesQt5zaWJH2HH+EtFDzn16rHicgFqMRpjPs2r59Pm1mdiSwHFBHqoEJZ48Nx69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588236; c=relaxed/simple;
	bh=jrjZjL17bww7dT1m4NZ4OYOrARcdrVQ3+OHkBqFx6vI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dMHmsA20apdqG8kJdbTuvjrEFJPx8I2RjRmeI0jyV0oqlXx+guy45lwCql3J7SVrrGvqP4jhsjB/HusvWR+iPeBcjOfPYmyd5eMrjXXoulo+NZMqkKXMFVqDHEibnbqTwFn1f/JhQzT2FjtYK1qWKw8UVQc69E0AgJ+DSPOplWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKuueJKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKuueJKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB38B1F000FF;
	Mon, 28 Sep 2026 09:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588235;
	bh=477m7LQM4RfI/t00mgnuTJye4OL32Hhc27QvgIqXXBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dKuueJKaaK4Oozq4uROreXbMnHcbNcnN0Zs4v9vmopj/Xw6YI83KZ2WSHOe8TbuKe
	 m/aFlzkeAoSTjZ4G7fwvlykm99WjaQNybLdCrniu0CGoYZdgtEAeCm6jc2qMVJfnXU
	 goFw0YWXVBkcAfkl7va3WuxBTcK0CwrySptfhR/kEbyLQV+pEzoNeuCOPMxukdXvwH
	 QCWd66gcOUwlr5p1HjAPGl4aYwp2FT65B6jpTK3sYxZ6sAX0q/cY7Jmoxk3C9RwzEQ
	 0fujym9evd5vwMlj/3HXqwwcmZKiX+PTbfW03SC7yeW9doFbmDSr2yN8+69G42/+nQ
	 54Vyz1gxlwR0Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 4/8] mm/damon/tests/core-kunit: test
 quota_goal->complement commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260928093342.16584-5-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
 <20260928093342.16584-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 09:37:14 +0000
Message-Id: <20260928093714.EB38B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend existing DAMOS quota goal commit unit test to test the complement
> flag.  Set the source complement flag and confirm the destination is
> updated to the given input.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928093342.1658=
4-1-sj@kernel.org?part=3D4

