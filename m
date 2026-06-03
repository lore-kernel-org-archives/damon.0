Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED053D75A8
	for <damon@lists.linux.dev>; Wed,  3 Jun 2026 02:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780452700; cv=none; b=j6SKl1znMgDSNV1DkpRctisqOXIA7OdyYZusBSfVDNEJ7mn+72CwbsECfYeK2iSOgQ8Q5fVhUvWkqABat4OaNdBITrmGMjha/cf0Q5d8GbrRHRCMBNgjQTRMBqkl0E7DhvRGJgebt2hXtJQGLx6odCvK0UCAaaU5P7LnVlqrnws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780452700; c=relaxed/simple;
	bh=lQhnx1Sc9lVzGUfF2mzbQ61SmFZDB6lO5OckYW0liV8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=c2IojHVmgW9yES5+LiHxW4PGnl86SBQU25BnWBY4Pi7EALC14Xq/6dhyqWqSQLoNSmUsT08tTLhkE1z9eRkDNrtd4VA/SoSD2dMFrgK0cmEg5PvY1lLLdnzpfqEkPRVmzB0QyvP5CP1xDvduxQt8yz1v5axlUc9LGNedQOu8xgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fet6fDSY; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fet6fDSY"
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780452696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWcXO5uoIwwgO4Aa+YYZakt6JMfCreyx3cspW4io9Lw=;
	b=Fet6fDSYiGjeiF+vRO7z6BJFZX/dR9CMeWUIFtJFE9creS+yD0JQBGuWgGQUhyP6XrNmHh
	Z965wlncTfP1tOwChoVENLJB8dzP9PWkSK2e+l9omXLG0HKsFd6y4J8uyFX83oe+kM9BtW
	uFt/qF9a1de8Y91NqhGy9DIvSJvw7gE=
Date: Wed, 03 Jun 2026 02:11:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <38c4d77974349f9783478a04c46df6f975d41c84@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 0/3] selftests/damon: misc fixes for test bugs
To: "SeongJae Park" <sj@kernel.org>
Cc: "SeongJae Park" <sj@kernel.org>, shuah@kernel.org, damon@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Kunwu Chan" <chentao@kylinos.cn>, "Andrew Morton"
 <akpm@linux-foundation.org>
In-Reply-To: <20260601142234.111301-1-sj@kernel.org>
References: <20260601142234.111301-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

2026=E5=B9=B46=E6=9C=881=E6=97=A5 22:22, "SeongJae Park" <sj@kernel.org m=
ailto:sj@kernel.org?to=3D%22SeongJae%20Park%22%20%3Csj%40kernel.org%3E > =
=E5=86=99=E5=88=B0:


>=20
>=20On Mon, 1 Jun 2026 11:23:11 +0800 Kunwu Chan <kunwu.chan@linux.dev> w=
rote:
>=20
>=20>=20
>=20> From: Kunwu Chan <chentao@kylinos.cn>
> >=20=20
>=20>  This series fixes several bugs in the DAMON selftests. Most are
> >  trivial but cause tests to silently pass when they shouldn't, or
> >  fail prematurely on slow machines.
> >=20
>=20Nit. Only patch 3 fixes a fake test pass for "avail_operations" file =
existence
> test, and the series is not doing something for slow machines, right? I=
 think
> the last sentence should be updated, for example:
>=20
>=20'''
> Most are trivial but makes test output wrong or even silently pass the =
one for
> 'avail_operation' file existence check.
> '''
>=20
>=20Other than that, all look good to me, and already have my Reviewed-by=
: tag.
>=20
>=20Asssuming you are ok with the above change, I applied this series to =
damon/next
> [1] tree with the above change. If this series is not added to mm.git i=
n short
> term (~1 week?), I will ask mm.git maintainer (Andrew Morton) to pick t=
his.
> So, no action from your side is needed for now. If it seems I also forg=
ot
> doing that or you cannot wait for my action, please feel free to direct=
ly ask
> that to Andrew.
>=20
>=20[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-pro=
file.html#scm-trees
>=20
Hi=20SJ,

The updated cover letter looks good to me, thanks for fixing it.=20=20
Thanks=20also for applying to damon/next.=20=20
No=20further action needed on my side.

Regards,
Kunwu

> Thanks,
> SJ
>=20
>=20[...]
>
