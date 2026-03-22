Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC02D2496;
	Sun, 22 Mar 2026 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774199483; cv=none; b=Wq8ZrIdv3oVVx/qIJIFZ0lzIeuMtadnpSzUkHTJVr7CoLv/81Kbk8/JYMOvm98Ax5yhdZ/e2c6kxPO/0rmIp3mA4w+Tc9jgigdAOYmQ6KLQ6RdHYEYpAqA2PGtfTZX85RUypKUanQETgvAibE3dqxMvptvqIw2Pub7T1JqgcPR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774199483; c=relaxed/simple;
	bh=1GWDWgR17ErUUXJrTZk+G7OZwGwEUaiSwip7+aut2Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCnEoPs/LqHS5+dRth3OSL7h48IHIQwJNF9YsZOahemUVN+i3siKOPklkREb3yQ9eYbQoYSRj6GD+FbGyITxeThDxxfKi6X/EVTz4QxFAxiizY1Bxkw0GQR7p6dgxDkrHTGYZkgxu6Jgm+9fWV3DkIrUeQGHy/uiLQ7AdX8d4bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMREz7MM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMREz7MM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEE5C19424;
	Sun, 22 Mar 2026 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774199482;
	bh=1GWDWgR17ErUUXJrTZk+G7OZwGwEUaiSwip7+aut2Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KMREz7MMbbGt8fgJ1q5oJOSMdkWWglYdNCAcEN+6mKr/d6uxSPo4tanA/9MWx0g5a
	 PuCpvuZuy/5EHORXS5moIQxTamsgJTEKqRpMQ/XDComCVI48Aq4IFQlgdJlr9x5zt5
	 XiwB93IgDbWZccYZRIGGjxVMCzDRIa3A/n9CzA4Vn6Z6ZCrYRMqVs2s6OeplAQSK0p
	 uiRltAG6me1pzcwYJ+b2XYGTQMg7boNVL766m4DkkxqdAK4b7qIS6FbJ19o/yJ/lxz
	 cSDuxhVtpFrJMN7C+n913IbxguuR9hHDW5toILWbvG+lGz8Z1YghCkFmPbi/W8c1bW
	 mDIbTowoq6d8A==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [RFC PATCH v4 00/10] mm/damon: let DAMON be paused and resumed
Date: Sun, 22 Mar 2026 10:11:13 -0700
Message-ID: <20260322171114.83314-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322170506.82977-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Mar 2026 10:05:05 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding sashiko.dev review status for this thread.
> 
> # review url: https://sashiko.dev/#/patchset/20260322155728.81434-1-sj@kernel.org
> 
> - [RFC PATCH v4 01/10] mm/damon/core: introduce damon_ctx->paused
>   - status: Reviewed
>   - review: ISSUES MAY FOUND
> - [RFC PATCH v4 02/10] mm/damon/sysfs: add pause file under context dir
>   - status: Reviewed
>   - review: No issues found.
> - [RFC PATCH v4 03/10] Docs/mm/damon/design: update for context pause/resume feature
>   - status: Reviewed
>   - review: No issues found.
> - [RFC PATCH v4 04/10] Docs/admin-guide/mm/damon/usage: update for pause file
>   - status: Reviewed
>   - review: No issues found.
> - [RFC PATCH v4 05/10] Docs/ABI/damon: update for pause sysfs file
>   - status: Reviewed
>   - review: No issues found.
> - [RFC PATCH v4 06/10] mm/damon/tests/core-kunit: test pause commitment
>   - status: Reviewed
>   - review: No issues found.
> - [RFC PATCH v4 07/10] selftests/damon/_damon_sysfs: support pause file staging
>   - status: Pending
>   - review: ISSUES MAY FOUND

The status is pending.  'ISSUES MAY FOUND' is a bug of hkml.  I'm fixing it.


Thanks,
SJ

[...]
