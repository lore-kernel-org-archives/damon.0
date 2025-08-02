Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A8C13B;
	Sat,  2 Aug 2025 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153906; cv=none; b=HAFsySSVZGmnInQEYqGEzgOMF4jvv++kVTBkYZulieaekdN7WwhqnYVRPkiOq4kRx79Z82gG+zb75G57Q9ldZXdhR5T0FxXKsX6acq4d7a0A7Bch07wQjf3H1SQXlcjRH2fJjO4sW2DOgFqXPIQ169nhgsDNNpYJ+iWj7vV2lkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153906; c=relaxed/simple;
	bh=QkfgJx+v+j5j666EMkLWa+Ni4oABKMVRYbpkq1C5Pqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dwJX9gknoRtQdjH9PiucBT64qWonmKGtGAkiLZtCz4Vd2oYh4AMmFZ6ldxdnepxgssrTFrU9wOOgFr//AXTeE29q3bXbPV6mlFRa7R1cDrNWZgSb00jS3+DSxjY7fuvZv8U/SqHVIzLMUl+KRCHAp9jDfWswGqtji9kc5QegOkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFz4ra0H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFz4ra0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092CAC4CEEF;
	Sat,  2 Aug 2025 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153906;
	bh=QkfgJx+v+j5j666EMkLWa+Ni4oABKMVRYbpkq1C5Pqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFz4ra0HgVtSHcTAmcCVXD1C0hJaB9hvr3xAMPT1lFdqYKFzv5l1n8Gd49YPYUC4v
	 5ePJZ5qAxyAaqjrOInDLRUoZLmt+fwQt4JiacdHetK1hakwV6M5E8EzM5CFnuo8kBd
	 2B03gB2jJ9hUwnx1dq9Zic3uTT2GmBXd4X3Td8rS2vLeusz3yaTVT0cCY25lPitBu+
	 xrhlxZbGO3/Tca8nMtwk1zl1GGi51zOFomT6eR5LfI2Quw9EsYkrO3pHNDi5yfG1xn
	 foAQUtJ6RxHZdOYCVSWHmofNPlZkMNDxJHqV1Vv/4LnakrhKwyu4vSTnLm4n+ZNxs6
	 WT6s8nWY7srrQ==
From: SeongJae Park <sj@kernel.org>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 0/2] mm/damon/vaddr: support stat-purpose DAMOS filters
Date: Sat,  2 Aug 2025 09:58:23 -0700
Message-Id: <20250802165823.7277-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1754135312.git.pyyjason@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  2 Aug 2025 11:52:44 +0000 Yueyang Pan <pyyjason@gmail.com> wrote:

> Extend DAMOS_STAT handling of the DAMON operations sets for virtual
> address spaces for ops-level DAMOS filters.
> 
> Functionality Test
> ==================
> I wrote a small test program which allocates 10GB of DRAM, use 
> madvise(MADV_HUGEPAGE) to convert the base pages to 2MB huge pages
> Then my program does the following things in order:
> 1. Write sequentially to the whole 10GB region
> 2. Read the first 5GB region sequentially for 10 times
> 3. Sleep 5s
> 4. Read the second 5GB region sequentially for 10 times
> 
> With a proper damon setting, we are expected to see df-passed to be 10GB
> and hot region move around with the read
> 
> $ # Start DAMON
> $ sudo ./damo/damo start "./my_test/test" --monitoring_intervals 100ms\
> 1s 2s

On v2, I also suggested adding indentation here, same to the outputs of the
commands.  But, this is too trivial, so I wouldn't request a new version.

[...]
> Revision History
> ================
> Changes from v3 [3]:
> - Fix some naming issues and improper text in cover letter raise by SJ.

All looks good to me, I gave my Reviewed-by: tags to all patches.  Thank you
for doing this great work, Pan!


Thanks,
SJ

[...]
