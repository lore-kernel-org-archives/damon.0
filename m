Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB09053FD33
	for <damon@lists.linux.dev>; Thu, 17 Sep 2026 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655138; cv=none; b=B9vob/Ig4/3kSJWAVOx/FssQfh8kvc5Rllscsq7KRAKzmguovC7mt4wWnbhnyqTDRKnenDs4z/viJJgwX4HhC2IoAtl9qoO8MbPb/Ptw/d+lrcD+9Vh7j9cZsdWV/WX3OqKY4Nz4toLxhZCVQZQXvySiWaTaGXzzQj+Yhu+C/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655138; c=relaxed/simple;
	bh=lUlzZom5RjvB3duAmsM3hM87s9Jc3yGGjea8ML0a2QA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EKHf+Khf1zb+mKgX9MiEHX447HHPBTXSAW6tOg+32V6dtvOoNgmMSkLLY6FXXqkLthcN23lXsu1nUzCKAJyrhJYRoJtYtliCpETkoFU7TOvEIcPcmmeQV4mek9O0HTQPb39e2guMhNGIKDaqtWx/rbqaJ+pyMdfjal5oP3J2sQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOQxBMDu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOQxBMDu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D69D1F000FF;
	Thu, 17 Sep 2026 14:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789655136;
	bh=ycEA0Zsj36bJvk46d4rdfYqjU293pZxMfxxr1OQiaFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cOQxBMDuYtCF/v2WmVdP1UsjhwosEKGLsy4YNhaGD8Xi9s/E8OmXxBRtoDUdlS8On
	 osFDCQ6rpL+yKuOFHeAfDTZwjwbTlAJbvUXvF01tNOM7G6i+56syORf6uoB9INqY8l
	 9ciDx/XpsfwofLOhE4gODCbdiu0pBjjlwa+Kt+/iCnzxbanQl3QwfKLHZ7OVAh7+qY
	 VyXfUCxpDm3BnhBqPk/vt2ho5RIqjJKV0ewk9s9bIKeLT31dyfgffAXvDPwWTneU9q
	 BvtN69i++iqWDN8PlcNZYFQIgFb0opTqZchKjBpD8AZYH3vFHbOLgw58m/a1fslzDJ
	 PS0EiEwC3Ay6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] mm/damon/core: use abs_diff() in
 damon_feed_loop_next_input()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260917142210.90829-3-sj@kernel.org>
References: <20260917142210.90829-1-sj@kernel.org>
 <20260917142210.90829-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:25:36 +0000
Message-Id: <20260917142536.6D69D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_feed_loop_next_input() is open-coding absolute diff calculation
> instead of the dedicated helper, abs_diff(), for no good reason.  Use
> the dedicated helper.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917142210.9082=
9-1-sj@kernel.org?part=3D2

