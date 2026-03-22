Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7F61A2C0B;
	Sun, 22 Mar 2026 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774207608; cv=none; b=t8AZjvgnxZSlaEtC3RlMx/pZxiDdaRxjw3MhaWoz+ILwn/WV7zWNke2rU3U/VoNuwY4cG/icBzCsp1BLl+DQbImGSsAHYaluao9dF5c42Uq6F588YpcOnb1bSSn4rhDYmHFz1POvgcL1dwYr78iCGVUNgBRhyAhi3WbPcJ9eA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774207608; c=relaxed/simple;
	bh=X2DK8H4FcYtPiwS5iIb457FtPn7QN07ZkhbMOTso2XE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYCpyGQO1iJFNtPVpf3GmYFQTiDslaVIjC4tnnCznBNVp191kbw+iQLkWTCIEMaP0Iq02Npecpm15r8n2DH9Jzc8VnbErRmH9tHIzko92xA5QMNauAn0JQEcpHojX0BkywYtAzKRZPIGwgJ8zreO8LX2sGGj0wyQaGN0uJU7hBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiZD1+x/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiZD1+x/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACB1C19424;
	Sun, 22 Mar 2026 19:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774207608;
	bh=X2DK8H4FcYtPiwS5iIb457FtPn7QN07ZkhbMOTso2XE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UiZD1+x/nVOYnkRO5qYh824b+4jHHTlKk0D8ItIlwe6xN878lJgYIeLdhlrMnIT3m
	 RMe8k6LPrBU5LA0ckrvSPYCU7l3PIE7ABUVuU9E+B7W5QfGLG/4PSrBhWsAX5RKmSz
	 o3qrMQvaL/KvVM4jFc1ilhEmqkK7ZzoVpw4QaShx/p4G737WNesAnW8Ck33sV3FP70
	 r0rKJgsMjEWE+pZ82cUiiKzHemb60reqp8ODiBFS5EtojiM9tQV3ftjA00FTgxfmWI
	 pcd2OUb9Y10IpYCrlf8IxEwu6RCjnA4fiHL5yMvuu5GOGZpNWlLDkfJqCQidVSnm+A
	 advWRx6HtLSXw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 15 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: avoid use of half-online-committed context
Date: Sun, 22 Mar 2026 12:26:40 -0700
Message-ID: <20260322192641.87848-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260321021628.78887-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Mar 2026 19:16:35 SeongJae Park <sj@kernel.org> wrote:
[...]
> By the way, I am also doing monitoring of sashiko.dev for all DAMON patches.
> It will be much easier once sashiko.dev's email feature is ready, since I
> already onboarded DAMON for that.
> 
> Meanwhile, the monitoring using web browser is somewhat tedious for me, so I
> just implemented an hkml feature, namely
> 'hkml patch sashiko_dev --thread_status'.  It receives a message id of a mail,
> and prints the review status/result of all patches of the thread.
> 
> E.g.,
> 
>     $ hkml patch sashiko_dev --thread_status 20260319-memory-failure-mf-delayed-fix-rfc-v2-v2-0-92c596402a7a@google.com
>     - [PATCH RFC v2 1/7] mm: memory_failure: Clarify the MF_DELAYED definition
>       - Reviewed (Review completed successfully.)
>     - [PATCH RFC v2 2/7] mm: memory_failure: Allow truncate_error_folio to return MF_DELAYED
>       - Reviewed (Review completed successfully.)
>     - [PATCH RFC v2 3/7] mm: shmem: Update shmem handler to the MF_DELAYED definition
>       - Reviewed (Review completed successfully.)
>     - [PATCH RFC v2 4/7] mm: memory_failure: Generalize extra_pins handling to all MF_DELAYED cases
>       - Pending (None)
>     - [PATCH RFC v2 4/7] mm: memory_failure: Generalize extra_pins handling to all MF_DELAYED cases
>       - Reviewed (Review completed successfully.)
>     - [PATCH RFC v2 5/7] mm: selftests: Add shmem memory failure test
>       - Reviewed (Review completed successfully.)
>     - [PATCH RFC v2 6/7] KVM: selftests: Add memory failure tests in guest_memfd_test
>       - Reviewed (Review completed successfully.)
>     - [PATCH RFC v2 7/7] KVM: selftests: Test guest_memfd behavior with respect to stage 2 page tables
>       - Reviewed (Review completed successfully.)
> 
> I'm planning to implement another feature for formatting and sending the review
> result and inline comments as emails, probably this weekend.

Now the feature is available on 'master' branch of hkml.  I started using it
since yesterday for DAMON patches, and it works for at least my workflow.  The
documentation is also updated [1].

[1] https://github.com/sjp38/hackermail/blob/test/USAGE.md#forwarding-sashikodev-statuscomments-to-mailing-list


Thanks,
SJ

[...]
