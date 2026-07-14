Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A6013D886;
	Tue, 14 Jul 2026 04:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003684; cv=none; b=FA2uhLLEW0ippUPjADYcswQYfHYSh/+cymTpBFm7HXey832+dEuWxmxx6b7u2xN73usOl4NcD81Po/QVzWI0QN0NQ5AdWdp9C49PAksywC3Va5Xvaqzd71iCPGYeUUVCbil5df+0PLLa0+eCqvfPZp6OxfHM7jOMVqknf2ynmBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003684; c=relaxed/simple;
	bh=JTfN4vhhn38AsnFtmKZswoqEKbnfNg2Tnh6SGvnqeMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e0P0UBh3Mg/HfXenLTFmX5gZKgxYjzpyIHCI1n1ehho/1YnT1T8+9dfixLgxfqQi4jak+nyK7Omp+bbyU3l0OlnxfBx7fSiuFei9dDgxBpn3iyoHCVc4o191LIVadN2taeHSlxidNOyfCtx0venZVocAhn6bvHVsOk718TWlCrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drn30NTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drn30NTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7201F000E9;
	Tue, 14 Jul 2026 04:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003682;
	bh=5HorvAmOdD8OW3Wub7kaOWmH60W1P8iHnRf74xopIeM=;
	h=From:To:Cc:Subject:Date;
	b=drn30NTuEyGs0VhHRcO2ejG3YH6liKQeRe5AxNWRh4i/+A7XpsuZmrdwvvX+lwJSl
	 6AOeFEtEzP2ViEBt/iijZ3ehOfYqar+arJbzUHe2tAOkP3cAEd/hu9Smprb7kIxoX8
	 t3QlN8GCMK60uFV9IJ7ihwhEMvhhTBluAKDKNjNFj1BiBRC6yx3Yj1dPK+Pi+3rR3p
	 6DOZsqtarnk0GVD+7HgGYPXnExDizW1R/P+MbLlVe6t8nn7qEVM5c54prvGLUxAPW/
	 bEPxRqBbBOh4ix9OHRKoKgxE2wi3HFVfeFoBdjWTdkr/YHC4uRJU+bOFVFaTFnIBX9
	 BlAa6+mUSZN4w==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 00/10] mm/damon/core: hide core-private struct fields
Date: Mon, 13 Jul 2026 21:34:26 -0700
Message-ID: <20260714043437.95811-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON core structs hide core-private fields using 'private:' comment
tags.  It is incomplete and inconsistent.  The linked list heads in a
few structs, for example, are intended to be hidden, and always be used
using the wrapper macros like damon_for_each_region().  But those were
mistakenly marked as non-private.  A few core layer-only fields were
also mistakenly added as non-private.

This only encourages callers to directly use the private fields.  It is
easy to make mistakes, and difficult to control.  Mark all such DAMON
core struct fields as private.

Patches 1-8 mark the private fields for damon_region, damon_target,
damos_quota_goal, damos_quota, damos_filter, damos, damon_filter and
damon_probe, respectively.  Patch 9 removes DAMON_SYSFS's direct access
to core-private field, damon_ctx->ops.  Finally patch 10 mark the
private fields for damon_ctx.

SJ Park (10):
  mm/damon/core: hide private damon_region fields
  mm/damon/core: hide private damon_target fields
  mm/damon/core: hide private damos_quota_goal fields
  mm/damon/core: hide private damos_quota fields
  mm/damon/core: hide private damos_filter fields
  mm/damon/core: hide private damos fields
  mm/damon/core: hide private damon_filter fields
  mm/damon/core: hide private damon_probe fields
  mm/damon/sysfs: do not directly access damon_ctx->ops
  mm/damon/core: hide core-private damon_ctx fields

 include/linux/damon.h | 110 +++++++++++++++++++++++-------------------
 mm/damon/sysfs.c      |   2 +-
 2 files changed, 62 insertions(+), 50 deletions(-)


base-commit: ddf3f75c217672edd46466c9156d64abf5119b68
-- 
2.47.3
