Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E684042C50F;
	Thu, 24 Sep 2026 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235221; cv=none; b=VlgYYrsUBIBvBP43XLxoMMOlA0xn/2Xy182oiWd/ZU8kKu6GtBbghDLyykjnpyagU5CfvgQ/LluIgWqiXXMrDE91Gz2Th14ZQXtRB85GtLqBKxiJeMcLgOxwtEmfR3MaJtyw1CtO1rw3PidmusskdMuqiOCnSzpnhilkSk1narU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235221; c=relaxed/simple;
	bh=CqDPGVqiH0EO8pIrWWBnkvea4lq4xEXg4sRNoH80G40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilY67F+H8iJvRK4O4SiBrjB4k06L9QSsvRY3Nj+4vt18CR/5S+nKztKfcG6ohaW5CZnOg27mf9SnPUuD+yWFdraGJwAAkcH9nC0ipvSznYyTf2d/D3rPcKuSdU9sOcFive4N4ulbSVQpIwOun8IK065qB+OIvGrAtOnq2LzuW8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fhn+7D+e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhn+7D+e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536641F000FF;
	Thu, 24 Sep 2026 07:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790235220;
	bh=H5Q3QsVfjPbwHPredQl/X4zsaUQV/JInoABBnQSnw6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fhn+7D+e67rHaXPDUh3AOVhf7mjueV2X8n8PyxcwU6Fv4wFT6wdhOGd/lU5omuykW
	 kTROp/SUjTAWT7Z2enCDG26KMlM8sVn3XkIk3DELRNUNSymlZTstHKGXcG52suoWP5
	 6WaYxmeRGb1+NKg5yUr7hZvMJW6iCjQkdEaJmQRwfNEBp+8GoR3aUbc1HB1iFNbMUE
	 ahKcDVy+pEcMj/ES2IqXrD5OPvrYPwinxceNF3Y2qyw7uP0U9SvEBdHa5Mh90gle+3
	 LEL84QuPuD032GGpvhalZOKIrt9mlmK1v12M3061d4YjSj5sDvtbC3ToV+yuz3uf6F
	 eUpAQ2ImpC2Rw==
From: SJ Park <sj@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: preserve the caller's quota in damon_new_scheme()
Date: Thu, 24 Sep 2026 00:33:36 -0700
Message-ID: <20260924073337.7440-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <arRHl5blMrrmvhkU@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Sep 2026 23:46:27 +0200 Karl Mehltretter <kmehltretter@gmail.com> wrote:

> On Tue, Sep 22, 2026 at 05:08:44AM +0100, SJ Park wrote:
> > To calrify my opinion more, "caller's quota" feels unclear to me.  I hope it to
> > be more clear that it means "the quota that is passed as a parameter to the
> > function".
> 
> I've made it explicit that this means the quota passed as a parameter
> to damon_new_scheme().
> 
> > > > 
> > > > damon_commit_ctx() first copies the running context into a temporary
> > > > context for validating the proposed parameters.
> > 
> > I'd prefer using the term, 'commit' instead of 'copies' for clarity.
> 
> Changed to "commit" for the context operation.
> 
> > Now I understand you added the comment for commit 60bd24f272d0.  I think Fixes:
> > should also be 60bd24f272d0.
> 
> Agreed. I checked the diff and earlier callers. That commit first passes
> the running context as the source. v2 uses it with a plain Cc: stable.
> 
> The LLM suggested the wrong tag, and I didn't notice it when checking it.
> 
> v2 is rebased on mm-new and passes all 46 KUnit tests on x86-64 and
> i386. I'll send it soon.

Thank you Karl, looking forward to the next version!


Thanks,
SJ

[...]
