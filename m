Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1563B14B6;
	Tue, 29 Sep 2026 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669851; cv=none; b=QPuY+akVu/RCQqPpXtWb1Oko7wHRAakZ1R9SIX/UEjrBKC0aCyDUM4LO9uIPvBHDQG5DjFEvnhVWi3lAB1eVIEf7F5NMPVXNJudS+y+gchbrgoLWgO1xiIe1lfJntC7eA56CT5zOvEvREPqzasVWZJN3YKRtsElanTWGLPU17fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669851; c=relaxed/simple;
	bh=ewJKq01X7cz2Ue1vFMiTUnv0exHdMMW+tmYvr0degLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqnId6wP1TemYeg64uR0wz1HZLqJYC3mNY/VnC2Z6dhvMfDyQ/9Q1/N5fqszcBOTohhkloJozTmxuTplJpkXJfio7qW7KHk2GTnQAgOyJlQ4KZ60Sti47Me+Whvat4SbaBdLkDjurZzSluwRLYZbSw8aO3PR+xHMse/3igV0GaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa6Au49P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa6Au49P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3471F00893;
	Tue, 29 Sep 2026 08:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790669849;
	bh=5QoHG/n2/laaRy5rYicMZNSwTjNxom3qwPZeDoYqp/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aa6Au49PkqG2GJ9kFSljN4pEa9AfiwGP+zm0xec/WFPk3XCdHnxy0/mQTtM5eAnGA
	 s7G3E65Y+aG80L2rH4F4OSARJoQLMPrcnkmjUrSsOnv7PRqaJIOrwsDsM+TSbsR+ll
	 JKAe5PL/FV+/rYvDCTpa/LpNZp4+X5UjV+hl1KzJST91v6X6+Ca5ZTRyCw+Ry6X4//
	 mUMhaJwpurdZ0dUjkBJ9JPBalAu3dwaJ8b+D1Y59cOKeat6c/AT+RfrXyJ5etx1fT2
	 1aInKxoGrcl4Rpm1V2I0KWaxBa9K4Mn6nDABCh3mi7dLdZleG+pWAnC9Zb0aDZbOHF
	 GRYz++HJvTYhA==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
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
Subject: Re: [PATCH 0/8] mm/damon: introduce damos quota goal target metric complement flag
Date: Tue, 29 Sep 2026 01:17:22 -0700
Message-ID: <20260929081722.42380-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929080113.41708-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 29 Sep 2026 01:01:03 -0700 SJ Park <sj@kernel.org> wrote:
[...]
> Add a new flag, quota goal complement, to allow flexible tuning goal
> setup without unnecessarily increasing the number of metrics.  The flag
> specifies whether to use the complemented value of the given goal metric
> for the tuning.  For example, if the complement flag is set, the upper
> tier memory utilization ratio metric works the same as the free memory
> ratio metric for the tier.

Sashiko found no blocker for this series.  Sashiko sends its findings to damon@
mailing list [1], and I reply those if anything needs to be clarified.  Please
refer to those for details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
