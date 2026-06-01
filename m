Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7371E5201
	for <damon@lists.linux.dev>; Mon,  1 Jun 2026 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780279783; cv=none; b=eldgbylSzQSGhoGpwi0A2lrfK9hni5yEZsM3fwtGg1Wagt/AObQxJpYvA3s66LdTjgeqDw2RMN+ZKuOBLqrbketCrtQ7zfkWrUUz7uwONxesW375LwM/PjeYsRxK/JPRKQPgdkg5NLBmMl1Lxna5J/TUN82TbmYDuV99X+snJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780279783; c=relaxed/simple;
	bh=QZP2A85Xqcg3HNc+IXmr6vnqo/AcJ5uB8mZrB6Cw5/k=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Mjt+TIs0uzTSDalUDrHeXdGaZG9O8Wf/GjLzgGibSaiae3xefd20n0sqCkeqK/FiL5tAXwtujYa6hiqv7dUQkHUxNFRrdikbc4kAv3XZ2MPub0b2I0RqXRnWivF+tlq7B6mdixcR0YXFNdGb/hn+lVb99BEaNW4N/9Y3mCKjslU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z5vH0pPX; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z5vH0pPX"
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780279779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDDfOFWy/TEWE9TK1LtUw0BuKs5gwFlMEYe/+sdHufE=;
	b=Z5vH0pPXLNpa0KFp9XL3PskVWUujMvCVP+qR6Dg5C6yYUAlM7lZAlnt8kPUAS41+c8vxuZ
	uRTIXsBiHU9oCpqYcF9ADzh0GXsF5YFt6qG9f/ltRhuK+HifqeTGKWWtCeh4LNnJg6ozlE
	pvOnmYr/SnamjcAvKZ/4FzeeTVN1cYI=
Date: Mon, 01 Jun 2026 02:09:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <1d19bb24fe6c1f6935ef078f7d7461e73590f21c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] mm/damon: fix stale TLB young-state handling on arm64
To: "SeongJae Park" <sj@kernel.org>
Cc: "SeongJae Park" <sj@kernel.org>, "Kunwu Chan" <chentao@kylinos.cn>, "Wang
 Lian" <lianux.mm@gmail.com>, akpm@linux-foundation.org,
 damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260531162457.98724-1-sj@kernel.org>
References: <20260531162457.98724-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

June 1, 2026 at 12:24 AM, "SeongJae Park" <sj@kernel.org mailto:sj@kernel=
.org?to=3D%22SeongJae%20Park%22%20%3Csj%40kernel.org%3E > wrote:


>=20
>=20On Sun, 31 May 2026 12:16:49 +0000 "Kunwu Chan" <kunwu.chan@linux.dev=
> wrote:
>=20
>=20[...]
>=20
>=20>=20
>=20> We think that makes sense. Explaining the rationale for not flushin=
g TLB,
> >  the limitations this can introduce for tests, and recommendations fo=
r
> >  choosing reliable test working set sizes would be helpful.
> >=20
>=20Thank you for kindly accepting my suggestion.
>=20
Thanks,=20SJ.

> >=20
>=20> If we later find cases where the documented recommendations are sti=
ll
> >  insufficient, we can revisit more intrusive approaches.
> >=20=20
>=20>  I'd be happy to help with the documentation work if needed. Please=
 let
> >  me know if you'd like me to prepare a draft patch.
> >=20
>=20Yes, please feel free to send a patch! :)
>=20
Will=20send it once I have something ready.

Thanks, Kunwu
> Thanks,
> SJ
>=20
>=20[...]
>
