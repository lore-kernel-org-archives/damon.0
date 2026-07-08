Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA299299937;
	Wed,  8 Jul 2026 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521295; cv=none; b=mQmjyEBg+FQfOVnwOrrmznnbij74h51U59rOjz4ay7qibWc3tP73GWyce4Rn24gs4UsQO6K7L+CU6fyVbEEUIQH0C8QmZH7pmZSfI1fw5/6sOgaYQAjNJWi9DZu7alwfJIsVxpwKtHknswmvDpkLSKiiZwyDuqXLFnNuuN/Nl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521295; c=relaxed/simple;
	bh=pjTyzaNAKSw+eKvneCrBdyGk6VIVRW8L2dHJScqbqIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/uii3ntTKezRegNC+Y93mHckcvqiW91lN7wK5QDAXpfcNK63V8MwX9rmjGrONknH7MeVRd/A4MVud594Sw9a2neofAmR24wsfYv6Pz5eMz9ad/29du2LukV6VhReldm0fZyOOyUWeGl4dCcew96Bckm60XbPyloN2KSFtsPXqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D36FJEsc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D36FJEsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F961F000E9;
	Wed,  8 Jul 2026 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783521294;
	bh=KR0z1qH6uK2oh0e9bS/ZqKqDovpkPToLeSanSQYH2IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D36FJEscYmwxWht1HE9CF14nZTTYEi7G76T8i0AqN+AdfbT+bSDXolYjL088bcG/r
	 oruvn1N9Soq5DY9dVQAxjWcJBmwS4BE2uRmlcBTC+qBAlEe8pmhabLZ5cp0Tw4mxQX
	 wZlt3y+DPEN1t2J53gCqSPnkDWf02Lhfm4vN6oeiSnLRyP/Uh3BWpF5YPJba1GgVxZ
	 jokGygMlT8dEdj/NruiEKm06Cvq9bW9v0bNBgLoyZR9RNqARu33CtGpOje6HZL4FM7
	 5UP61kR4I7tv+exyE5XYcJoxzPLL1Ul5+G+u6l5gVpidZUc4yHRs7UO3THliDK9TyD
	 r5ICDLTWIhf7g==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] mm/damon: update probe hits for runtime parameter commits
Date: Wed,  8 Jul 2026 07:34:40 -0700
Message-ID: <20260708143441.124565-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708135359.122587-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  8 Jul 2026 06:53:50 -0700 SJ Park <sj@kernel.org> wrote:

> DAMON users can update DAMON parameters such as sampling and aggregation
> intervals at runtime.  For such changes, monitoring results that depend
> on the intervals should be properly updated for better accuracy.  For
> example, the access frequency counter (nr_accesses) is updated.  The
> data attribute monitoring counter (probe_hits) is not being updated,
> though.  Do the updates for new parameters.

Sashiko found no blocker but a wrong function name [1] on the commit message of
patch 1.  In short, need s/nr_samples_per_aggr/max_nr_accesses/ for the commit
message.  Please read my reply [1] for more detail.

Andrew, as it is a relatively small change on commit message, could you make
the fix when you pick the patch up?  If you prefer v2, please feel free to let
me know.

[1] https://lore.kerrnel.org/20260708143130.124419-1-sj@kernel.org


Thanks,
SJ

[...]
