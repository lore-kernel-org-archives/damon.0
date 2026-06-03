Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4ED37DE84
	for <damon@lists.linux.dev>; Wed,  3 Jun 2026 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478106; cv=none; b=bT3YXPeRtm23T3PU3+UfSSl60247PUKSdlp1HYA11dCNBiowKjitiFj/CdJkQW5o9aw4JAYwHkqVdtd200uUYv+qrc7fualADFHon61OaSbQd5W1yRNNVz+0ZWOPa3CMwk9i4PwpQKCYIf8VFjz7Tx5wUj5nnH7oyurC6zt51LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478106; c=relaxed/simple;
	bh=zn7Seecs3LOSvLfv2aTTNGUwNVSAR/tJOyZPAL/5F2Q=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=cQ2XXLjRBeBejyhLEWlaA5dx7/It+KLCuQ0Pd3BHsYFhNCcOAZc7BijkAB2GnfyA1zLIj/KnfRlTI9NpjRZge6/W/G2dG3bdnMdIb8Q6IFHLY0vqoV+5pgjJENZ1LWCQe/rWbht5GuHyRz3z4r6Izti++cAhtidYD9PQcw+MDOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nIbQzVZ3; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nIbQzVZ3"
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780478102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wUny2P+n6s64FxOiYIiTZOU4vfbpKQNJRW9sV8W1Tag=;
	b=nIbQzVZ3H+WQX7NN+qawhZFTFRXfAXwxX6AJ/g0g/09kHk8He4+ve+LZlKYqbTxXHBj5UW
	KDShM9jzOLqSvJIxaKVKSpB9jWzIzPhMXzqfV/wsqnn0t/3wbn3A7eyhtqJdNWI4Q9AcKm
	k0Qsj1cn9FVSB8hIXPbvkmZscVdjwGg=
Date: Wed, 03 Jun 2026 09:15:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <1eeea60ae762c3969344592bd58a50082877ce02@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 0/3] selftests/damon: misc fixes for test bugs
To: "SeongJae Park" <sj@kernel.org>
Cc: "SeongJae Park" <sj@kernel.org>, shuah@kernel.org, damon@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Kunwu Chan" <chentao@kylinos.cn>, "Andrew Morton"
 <akpm@linux-foundation.org>
In-Reply-To: <20260603050219.91743-1-sj@kernel.org>
References: <20260603050219.91743-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

2026=E5=B9=B46=E6=9C=883=E6=97=A5 13:02, "SeongJae Park" <sj@kernel.org m=
ailto:sj@kernel.org?to=3D%22SeongJae%20Park%22%20%3Csj%40kernel.org%3E > =
=E5=86=99=E5=88=B0:


>=20
>=20On Wed, 03 Jun 2026 02:11:33 +0000 "Kunwu Chan" <kunwu.chan@linux.dev=
> wrote:
>=20
>=20>=20
>=20> 2026=E5=B9=B46=E6=9C=881=E6=97=A5 22:22, "SeongJae Park" <sj@kernel=
.org mailto:sj@kernel.org?to=3D%22SeongJae%20Park%22%20%3Csj%40kernel.org=
%3E > =E5=86=99=E5=88=B0:
> >=20=20
>=20>=20=20
>=20>=20=20
>=20>  On Mon, 1 Jun 2026 11:23:11 +0800 Kunwu Chan <kunwu.chan@linux.dev=
> wrote:
> >=20=20
>=20>  >=20
>=20>  > From: Kunwu Chan <chentao@kylinos.cn>
> >  >=20
>=20>  > This series fixes several bugs in the DAMON selftests. Most are
> >  > trivial but cause tests to silently pass when they shouldn't, or
> >  > fail prematurely on slow machines.
> >  >=20
>=20>  Nit. Only patch 3 fixes a fake test pass for "avail_operations" fi=
le existence
> >  test, and the series is not doing something for slow machines, right=
? I think
> >  the last sentence should be updated, for example:
> >=20=20
>=20>  '''
> >  Most are trivial but makes test output wrong or even silently pass t=
he one for
> >  'avail_operation' file existence check.
> >  '''
> >=20=20
>=20>  Other than that, all look good to me, and already have my Reviewed=
-by: tag.
> >=20=20
>=20>  Asssuming you are ok with the above change, I applied this series =
to damon/next
> >  [1] tree with the above change. If this series is not added to mm.gi=
t in short
> >  term (~1 week?), I will ask mm.git maintainer (Andrew Morton) to pic=
k this.
> >=20
>=20FYI, we are now quite close to next merge window. We want to focus on=
 making
> mm.git more stabilized and therefore ready for the next merge window, r=
ather
> than adding more changes that no really urgent. I understand this serie=
s is
> not really urgent. Hence, I will request adding this to mm.git after ne=
xt -rc1
> release. Let me know if you think this is really urgent.
>=20
Waiting=20until after -rc1 is perfectly fine, this series isn't
urgent.  Thanks for letting me know.

Regards,
Kunwu

> >=20
>=20> So, no action from your side is needed for now. If it seems I also =
forgot
> >  doing that or you cannot wait for my action, please feel free to dir=
ectly ask
> >  that to Andrew.
> >=20=20
>=20>  [1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-=
profile.html#scm-trees
> >=20=20
>=20>  Hi SJ,
> >=20=20
>=20>  The updated cover letter looks good to me, thanks for fixing it.=
=20
>=20>  Thanks also for applying to damon/next.=20
>=20>  No further action needed on my side.
> >=20
>=20Thank you for confirming!
>=20
>=20Thanks,
> SJ
>=20
>=20[...]
>
