Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E633F8A6
	for <damon@lists.linux.dev>; Thu, 25 Jun 2026 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782398209; cv=none; b=LFVWn+TfotXd9nVezURHVo3wmL2YEvrznQdMuYX36fZbd/MCicRo7gOQTe3iy6NQ7l50R6i8IcugriauN35BD2K/52v2e+RoPJ71zvJbyf+AH5oU3/aQAOIpfObpovktwtLLrE1fWcaPoBQmPCocdtb9fHx9lUG7EAsNvTvy6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782398209; c=relaxed/simple;
	bh=DsrhOihLUmyhy//9aRPzRq2hPe1tMZO8kEFxS4z2nh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPngQxFZhLU/vrKWgero6CINu57A4pDEf5Kpfn6MsswREkdsBFdd6j5Xa8MIBoF31gl09Y8co0coE3b7g+DmJnNjJMYmtBG300Wm8/htMyV0Bz/W/D2j6aRdWHB40Bl+14kbgQytHBqmcgbsFaB3Vg9DiJ/2tTmu3AA8jhtkKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvT2RIQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvT2RIQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627B11F000E9;
	Thu, 25 Jun 2026 14:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782398208;
	bh=lG9YqqaGiXm8OUwLSPk6RnOxqHgFG2s8Fr4hbkszMDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KvT2RIQesCWHfOMAaa5JdQZQfjBZuPZL9fhvdUA3+PuywBeD2HoW/Ys+YQrUSx9Sr
	 iVSB7DL2dy9JZzYGIbjOSm7vd7rPWFLGHLM+V8or8QLn+tjnzCMjfoMO9j76p9A1hU
	 MESdHT+67taujwj6lLFoPlrb2+8AbBHgN+eN7r3/ouvZdMTAvmfC2fnOXip4pnOEMs
	 Ho7dATW4xkucLutkBA0pghRoGWxfWhQEMSq7NUxstIqeNPlICamNGfYVOD2UpkZBmO
	 YH3RCwuVzWxYOfgYIPOwITWjAZwM2dvaq2oJTkEKaGu4D7gQkeaLvuEhvTZ1HTnOlL
	 24Nlom1F1tIzA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.2 01/11] Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
Date: Thu, 25 Jun 2026 07:36:41 -0700
Message-ID: <20260625143642.104633-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625142936.903F91F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Jun 2026 14:29:36 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Malformed reStructuredText inline literal syntax introduced for `node_memcg_used_bp` which will cause a Sphinx build warning.
> --
> 
> commit a9ffce1612fd4b4c8226cfb7a55a1781daa5364d
> Author: SeongJae Park <sj@kernel.org>
> 
> Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
> 
> This commit updates the DAMON design document to include the
> node_eligible_mem_bp goal metric, which was introduced earlier but
> omitted from the design documentation.
> 
> > diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
> > index 2da7ca0d3d17a..9dbace087a329 100644
> > --- a/Documentation/mm/damon/design.rst
> > +++ b/Documentation/mm/damon/design.rst
> > @@ -686,9 +686,11 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
> 
> [ ... ]
> 
> > -``nid`` is optionally required for only ``node_mem_used_bp``,
> > -``node_mem_free_bp``, ``node_memcg_used_bp`` and ``node_memcg_free_bp`` to
> > +``nid`` is optionally required for ``node_mem_used_bp``, ``node_mem_free_bp``,
> > +``node_memcg_used_bp`,` ``node_memcg_free_bp`` and ``node_eligible_mem_bp`` to
> 
> [Severity: Low]
> Does this malformed reStructuredText inline literal syntax cause a Sphinx build
> warning?
> 
> It appears the backticks around node_memcg_used_bp are unbalanced due to a
> misplaced backtick before the comma.

Good catch.  I will fix in the next revision.


Thanks,
SJ

[...]
