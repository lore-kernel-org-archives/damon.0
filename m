Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C4019A;
	Wed,  2 Jul 2025 00:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751415954; cv=none; b=iAhd61wzAZ5AHjadmizMRb4UzxiCFYLvtKi6eRwYTMCYrzIBUmmfrtsLJtr7uxfJOs2aQq+/+NDF0cfbvc23moYOyIUxbM2pPQOXhaJzWoH2VSPYHkZWwqWA25TlBL0UJ8sLT7st5nU5k9s4gWX4YCrH2Vo/bf6HpUtPyAm98S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751415954; c=relaxed/simple;
	bh=1JbVSOpm+VEAKh3Fc29zj2Q11yRj3OaDzc2pLpwbAfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fv9vRB7hr0yR3MtA+JYWS6o9UYgBr6+G7YxOWW4vFvrHZTJHY+XhmqsE8o3xAS+YxutT0MezqGCDu/SH8uXw0zXYLCWge19HK4bSYei5qdz++JtuAIGMwzMXMA97/1ENgUWEILw5tL7t8kNmpr5G5elSdInp7SGdQOG8dRilBqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCJZtZPM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCJZtZPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DAEC4CEEB;
	Wed,  2 Jul 2025 00:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751415954;
	bh=1JbVSOpm+VEAKh3Fc29zj2Q11yRj3OaDzc2pLpwbAfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vCJZtZPMDaIDjvqps59ipthFPvkpGeEUMivyNVbUcql7Ya4MQ370RmnK9XbDAtai3
	 MLIYpN9RARBXPaWwtKRIMOkizQ5ZK4i5MGAVIkublxggXPyPLkxdznWqEeKiJDwbvx
	 mSzsW/0wi6Tb7MG1nF5RCWE5nrBbRKDVM/T5J9YA1zzykphUnZoM+c6HKBVGevCh4e
	 Tw+0ym7hq0yATGmirfovgPYw01ssmXdD7t3cUeE8gEvNGAZ08qqEFJ/wNpxKklNBgZ
	 lGFypPqIl7DE74pWWTMVJczR3kS7y3sTL1ljYwU4mRyuo04Z6ZlqY0tRrK48R9pi0n
	 5yXD0VQyarCqg==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/4] mm/damon: add struct damos_migrate_dest
Date: Tue,  1 Jul 2025 17:25:51 -0700
Message-Id: <20250702002551.1246-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701224353.9062-1-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Jul 2025 17:43:30 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> On Sat, 21 Jun 2025 10:31:28 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
> > Introduce a new struct, namely damos_migrate_dest, for specifying
> > multiple DAMOS' migration destination nodes and their weights.
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  include/linux/damon.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index bb58e36f019e..d60addd0b7c8 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -447,6 +447,22 @@ struct damos_access_pattern {
> >  	unsigned int max_age_region;
> >  };
> >  
> > +/**
> > + * struct damos_migrate_dest - Migration destination nodes and their weights.
> 
> Nit: Can this be renamed to damos_migrate_dests?
> I think plural fits better because it stores a list of destinations.

Makes sense, agreed.  I guess you will do that on your own when you add this on
your patch series?  Please let me know if you prefer different ways.  I could
also do that and send it again as RFC v2 of this series.


Thanks,
SJ

[...]
