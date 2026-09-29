Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4DF39EF0B
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669266; cv=none; b=tL5YaA5cMdiw3Z2Ks/nWI4XzlnB6bTXRHkXLRkrzGYvHz4UCy2PC6rSPMhc+TJA+f2pywnKbqVr/JBWwNN42hpnsWs4lpfDqOKGDulz1sj1fBGqYAZE2QmguMy4EG4eLh5dose9LXzHXruim9MpiRWYqIHS+gIz3MJKxff4rHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669266; c=relaxed/simple;
	bh=lyP5hZvSFn0xtlf7v8NAT/96T5s+atz9w7TA5AxRdAA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ptqPtw1P4kjc/yaKdOQW8aRD9/isu6nd30dR+WpZfRUDmVaDe9WNHYAbl0IFCloJvP+ZCkmE/6qoAZ7RlJOtpeAc+i6UJYEpKvzznSOl2MB+EQoWJt+JcCCxGtxzAAl1BBmRIEipKrnr2rUCuvuKW6vjmLhtVLhoEwQIjW9zEfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAQDqy+e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAQDqy+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA661F000FF;
	Tue, 29 Sep 2026 08:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669265;
	bh=lyP5hZvSFn0xtlf7v8NAT/96T5s+atz9w7TA5AxRdAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WAQDqy+ejtNRDSM2iHbayHOvRUT7a8l17VQKMXWHiRTZ9jYKOJAsjO2rnbFw1J9mG
	 oigBCtxRFT3uF1Vj0JkWFoA6ReYQ3XzJk9lL7cxF1aqZmDOp/TiI1HDvW/FGYK1mNL
	 1METcOX6xsq9mp9c5+qxu8DMLLY7yiKy9ghYa/E1KVumaT+RmtnUTqYSLhSw6thdBC
	 wxdL/EQXfbopEjjZsriB3VHLqGE7dBy/VBhbwjLO5qN4wVjr9PrvnxPlhai44DE6BX
	 OcpdFzfYN9yUT+evKrByjPf4W/nc1SRojdw8qZeoo1t7V3sQCjnrJTyjKo2Y0fQ10l
	 STo/vKpOHTvVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] selftests/damon/sysfs.sh: test quota goal
 complement flag file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260929080113.41708-6-sj@kernel.org>
References: <20260929080113.41708-1-sj@kernel.org>
 <20260929080113.41708-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:07:44 +0000
Message-Id: <20260929080745.2CA661F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929080113.4170=
8-1-sj@kernel.org?part=3D5

