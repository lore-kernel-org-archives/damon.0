Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225F83C060E
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790511197; cv=none; b=aXG/+cx3fYV9uj+PD91vFL/1qoR78K4MJXgoQbHpdLX3CVXAXXObbT3BCUpX5/8V6z4jMy+JC4zssZaWjmIfKXnt2kwr293fLD4Rm6sV5NW2q2pqcFjkQ+0XMIiBa0TtrNtEC5BqkWlXhvfDuAV+V89pACDES/hSeNnpW7rWoP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790511197; c=relaxed/simple;
	bh=qjBdLb12DQHF+b8QxlSFvzJnL+auvRq5mS3lnl9y2q0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LGUghPwzExdYJTppnaOoifqQZEVbZ37NdJdkg0eEf8u7zAxd3iuiVzOJ7qJxqzrFIGzNf5r0mh1GPp+nTijoovIgVaAwYZoIreQPI72MZnxxI/u5S5sId8+Gz1BB6ronxe683ztELGtXe0cPRZtvuLN9Nl3n0UpWCfVfTx65EgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2jPptma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2jPptma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21FD1F00893;
	Sun, 27 Sep 2026 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790511196;
	bh=8z/kWcXqBoDMd7jdchM99VvYaJ+HGELaaX7np9h9MdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L2jPptmasmMxgE/ia6aJdePzfuDsooRi/yrbgurVcGhKn31q9RH+qbZWNFz0TRIj1
	 KVCwAPZ7H5nRBMCqKZn26KfLHmvKzxLKpZPPRcKQQhv/nNHPl+JH4bMZg4f+EhsECC
	 qRz06aLZg/GR47IGsTaOxOi89XgYSyUw/cRW1jLEODgbgUysLN8ksWSwWpe79vsxI2
	 gQL6IEWdT4kI1lOfy4SaY3wtFI/dfppLGkEzTNFQhMLpBzU0QD3rhHQsGqMusNTprz
	 XYo4cq6klGBQhFtMs8/D5F+m44XwP6RQz/iLHo6aPkaVG8aLgmm3ZVTuJBysm9Jc7w
	 +gu6j/wSvJYEQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 5/7] Docs/mm/damon/design: document damos quota
 goal complement flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260927120533.50484-6-sj@kernel.org>
References: <20260927120533.50484-1-sj@kernel.org>
 <20260927120533.50484-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 12:13:15 +0000
Message-Id: <20260927121315.D21FD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kselftest/damon: missing sysfs test coverage for quota goal complem=
ent
--

commit d3c6455ce7af443b98334d4d8484051c2827e265
Author: SJ Park <sj@kernel.org>

Docs/mm/damon/design: document damos quota goal complement flag

Update DAMON design document for the newly added damos quota goal metric
value complement flag.

> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/d=
esign.rst
> index e82390e77a70a..5cd651b1b7aa8 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -702,10 +702,10 @@ There are two such tuning algorithms that users can=
 select as they need.
>    that the zero quota is a valid quota, and therefore ``qt_exceeds`` :re=
f:`stat
>    <damon_design_damos_stat>` will keep increasing in this case.
> =20
> -The goal can be specified with five parameters, namely ``target_metric``,
> -``target_value``, ``current_value``, ``nid`` and ``path``.  The auto-tun=
ing
> -mechanism tries to make ``current_value`` of ``target_metric`` be same to
> -``target_value``.
> +The goal can be specified with six parameters, namely ``target_metric``,
> +``complement``, ``target_value``, ``current_value``, ``nid`` and ``path`=
`.  The
> +auto-tuning mechanism tries to make ``current_value`` of ``complement``-=
ed
> +``target_metric`` be same to ``target_value``.

[Severity: Low]
Does the kselftest framework need to be updated to cover this new parameter?

Looking at the selftests, test_goal() in
tools/testing/selftests/damon/sysfs.sh explicitly tests for target_metric a=
nd
other parameters, but lacks a check for the newly added complement paramete=
r:

    ensure_file "$goal_dir/target_metric" "exist" "600"

Additionally, DamosQuotaGoal.stage() in
tools/testing/selftests/damon/_damon_sysfs.py provides no fields or logic to
set complement:

    err =3D write_file(os.path.join(self.sysfs_dir(), 'target_metric'),
                     self.metric)

Could we add these test parameters to ensure the new sysfs feature is cover=
ed
by the existing framework?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927120533.5048=
4-1-sj@kernel.org?part=3D5
