Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154821B9F5;
	Sat,  4 Apr 2026 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775336798; cv=none; b=baa7nBWhw5IlItQsBTGPKJL7fkL03lcBAeWDNE5ufgALiTfa60F4C4S/hX9jR8Vr1q/ME9oCL4Euk6huCwu8Ao/2DbjQu1uS05PV8iAJhhU3owv+KDsIltwJ0JNNsXZsGkem+/XDk/FRIx/TOxlDUkTRlRmTfE4H9PFge+1zS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775336798; c=relaxed/simple;
	bh=4SryKwM7vsegLO0c1BFP+xu0X8RY5OoE3Nf4Yl1SFh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvVaYWLateoNsGfgQ8TY2qBHsuYbGw5wx03pQkl/61WccKkrYzg65tq7nHR7L/V+UhqTnyW2L34gKsx2h++kxy3K59+aP+fkjNIyaQtCd4UGLZLEqaWXQXTilStv0KgLPQl+ZiO3sbtRIWGNf22Gx5GcIfclbXakqD9zCqqegPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1syRjMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1syRjMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F194DC19421;
	Sat,  4 Apr 2026 21:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775336798;
	bh=4SryKwM7vsegLO0c1BFP+xu0X8RY5OoE3Nf4Yl1SFh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1syRjMYle4xMK+gSEsZrcuYSNG1IxBD6oDNJNvj60aCCos1ZGIJCcinPiEHdzH2F
	 0/8Qk7SwJrsUZDScopGiUSi9sNUdqJVHOaI465T5900BmJtO81RujxH/aHQYOhGwB2
	 6zenI80UAnJlu0lBDGmBYbxJ/u+GRuHu1BQLZbAv2x9fJgGreuGGNMyNkKvXu4sDbk
	 sgk8+bdXzlEZLqjItXYRUrBnAhCnjqv9i9JEnj2kHCCxxBcjaaXgwJWMZAeIlggg4D
	 dFHJV20oRnsIPTl6W7j3LbvBrrbRqYaLjMdmZbnaa7yYBOcWJ+TW0al2b5IwfgjToM
	 AIz82ny77TGpg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [RFC PATCH 0/9] mm/damon: introduce DAMOS failed region quota charge ratio
Date: Sat,  4 Apr 2026 14:06:35 -0700
Message-ID: <20260404210636.87762-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260404163943.89278-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dropped individuals from Cc list to reduce the traffic.

TL; DR: sashiko made a few useful findings.  I will address those in the next
revision.

Forwarding sashiko.dev review status for the overall picture.  Read my replies
to 'ISSUES MAY FOUND' patches for more details.

# review url: https://sashiko.dev/#/patchset/20260404163943.89278-1-sj@kernel.org

- [RFC PATCH 1/9] mm/damon/core: introduce failed region quota charge ratio
  - status: Reviewed
  - review: ISSUES MAY FOUND
- [RFC PATCH 2/9] mm/damon/sysfs-schemes: implement fail_charge_{num,denom} files
  - status: Reviewed
  - review: ISSUES MAY FOUND
- [RFC PATCH 3/9] Docs/mm/damon/design: document fail_charge_{num,denom}
  - status: Reviewed
  - review: ISSUES MAY FOUND
- [RFC PATCH 4/9] Docs/admin-guide/mm/damon/usage: document fail_charge_{num,denom} files
  - status: Reviewed
  - review: ISSUES MAY FOUND
- [RFC PATCH 5/9] Docs/ABI/damon: document fail_charge_{num,denom}
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH 6/9] mm/damon/tests/core-kunit: test fail_charge_{num,denom} committing
  - status: Reviewed
  - review: ISSUES MAY FOUND
- [RFC PATCH 7/9] selftets/damon/_damon_sysfs: support failed region quota charge ratio
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH 8/9] selftests/damon/drgn_dump_damon_status: support failed region quota charge ratio
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH 9/9] selftets/damon/sysfs.py: test failed region quota charge ratio
  - status: Reviewed
  - review: No issues found.

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260404163943.89278-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail


Thanks,
SJ
