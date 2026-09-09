Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39557D22E;
	Wed,  9 Sep 2026 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963053; cv=none; b=EMms945fegKOEDSsEkovQ8Azc+tebJ6TBfwgHvaN/b8GNoXDC5IfePHs3g7HpJlN30NVxxgMZhZyUoegP/pAiUYsy8MuFD7IPlcEk/rrKJguEv/6ckE2Ng053qujeGG6zS/MMuX3YrqAGdohFjhA7udsuZcid2SyiQemn/INmA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963053; c=relaxed/simple;
	bh=ZgibdlYM3tl5BTcEFpMhi4IiQYjmjdqNhDir7a1veQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVE+agUCnKFhtVAiutI2RIPrbXK0n0cSvgpcoGlsdGxslTyYadC0pMUgsRcVsxSvBjIBjCLDYJbu1fhk7354a7dYWh1gd4k0ZgjMcOxN8dFzUhJe4QMZP8oIbxVTmsLn/HIJ5j7pzYzNGaG9uAxb9h6Q3EvF5lhabdzQAUs3eCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1mlK8DV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1mlK8DV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B101F00A3D;
	Wed,  9 Sep 2026 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963052;
	bh=B1G0RE11rFuDv8wSwFJPMwA6T59xz3vA91P/lORF3w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R1mlK8DVE2PwiOkw+/PXbEwPI21LrBP20p7j9w8UB8vjSkz4wNAMoCcNY3JqrVsab
	 2tsWexYVhqmjeQc3ujZWA6SYioFZC4WB+fjA0OOa/M62Ch59BRMZb9/XiGSDYxPugr
	 uDSsjGy0qnDN/EFRxKLPOk9NAV4BSbMCrDIJxvpq3NwjJKhjH6//MfgCj2i5+8oHni
	 /eNwclIaDsuUgH4qTdf4+RgartRtTRGnmtI0Iwv0ATTX1O5US6KLMcIuG1EgenBPPv
	 sLJWWSVOc0OOrw5aXPSjAnZa/WhBuM7Iir0l8BfPQ6m0hOcvC/O5QR8346dGR6OyII
	 fVyUXLgzv7utA==
From: SJ Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lian Wang <lianux.mm@gmail.com>
Subject: Re: [PATCH v2] mm/damon/tests/core-kunit: improve nr_samples_per_aggr test isolation
Date: Wed,  9 Sep 2026 07:10:44 -0700
Message-ID: <20260909141045.105514-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260909070711.2448346-1-kunwu.chan@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  9 Sep 2026 15:07:11 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:

> Test the zero sample interval case with a non-zero aggregation
> interval, and keep the zero/zero case to cover the zero-result
> fallback.
> 
> Also make the overflow case use an explicit sample interval so that
> it does not depend on the zero sample interval fallback.

Thank you for improving the test.  This looks good to me :)

> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
