Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D871E4AE;
	Wed,  6 Aug 2025 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754440808; cv=none; b=h+4vVAXzKTU2p1lvcPQybjx6CR5GXjNcWyzptLLBgc9poNd+51d/HigkJykq4qH8ruS/v/CMU3sE20oFaSjMLwXox2/wGKxszqvTnTZKkok7Qnc5Ky9fY3Eb7F7h28AX4cobQJWCVDxLTcru/9tawgrLnKX7gcQSMXxigCWTR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754440808; c=relaxed/simple;
	bh=fPjD5D3HDLu3NtemT8rWbSgbD6qYNtA8uvatr0PW7QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RHxbwmMuAF7deWr11TjsY7Jmm+u3QKSzM5mylt/O2XjzmyJYI6QkGhdLSW4Xq6TBXu31m98C6SdUoHN8ITQZOercXYupPDCF0njUxVizP4T89e7nKdfA7j2+NN+H4qfFThxV8WU5gY3MwpxdAhYDU8OTOu7LjkkNWdoWjSkP6yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2U9Zsxo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2U9Zsxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D55C4CEF0;
	Wed,  6 Aug 2025 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754440808;
	bh=fPjD5D3HDLu3NtemT8rWbSgbD6qYNtA8uvatr0PW7QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2U9Zsxong5pC1ZCBOpeRRRkjZSlaDbpCpf36zSl0CRMtDzkH3JiV1H7RrMQP+W0y
	 dzXlMKgr71kVEzpOb0H+dYBsRzNT9MCliE8CVG3YLQbV9E5xbQteffDqRG5aW4Su+O
	 FXvwY/28e0XnP4znopWCug89r5I+cmj7Jfulh+ecw7AMp6eTSy/sKE5/Km96j6crT0
	 qAYpHUTeAK5cHjX5K3hd2hNEZsr/tp/3Uh1qKMOlJem5xYbFs7IMfDjc4Hi1hdkEPa
	 /HgzoMuKAbRn0Z78STDLuptxuBQGfZsGhaQZqHXZXyKM9Z0Se/n3lkMiQQN/Q61tea
	 X68lGEcLgl2hw==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH 0/5] mm/damon/sysfs: Add commands useful for using migration dests
Date: Tue,  5 Aug 2025 17:40:03 -0700
Message-Id: <20250806004003.52864-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250805162022.4920-1-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bijan,

Subjects of patches usually be converted into lowercase when be merged into mm
tree.  I'd suggest using lowercase even in patches stage, if those aim to be
merged into mm tree.

On Tue,  5 Aug 2025 11:20:17 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> This patchset adds two DAMON commands, commit_schemes_dests and
> wait_for_schemes_apply, that I have found useful for using a migrate_hot
> scheme with migration dests.

Thank you for this patchset!  I believe we shouldn't be afraid at adding
features, but should also be carefult at making good solutions for real
problems.  So, my main response to this patchset is, hopefully unsurprisingly,
I'd like to better understand the requirements and the problem you are
encountering.

> 
> The commit_schemes_dests command, similar to the existing
> commit_schemes_quota_goals, is used to commit only the dests fields of
> schemes. This has a couple of benefits:
> 1) It is more efficient than recommitting all the DAMON data.
> 2) Doing a full commit resets the aggregation and ops_update intervals. If
> a user sends the full commit command frequently (relatively to those
> intervals) the aggregation and ops_update events will be prevented from
> triggering. Having a separate commit command side steps this problem.

I agree the commit command of DAMON sysfs interface is inefficient, and could
make the infinite intervals delay problem.  But, I didn't expect there could be
use cases that use commit feature frequently enough to make the inefficiency
and the intervals delay be real problems.  Could you please let me know more
details about your use case and how severe problem DAMON is causing?

Depending on the real problem, I'm wondering if optimizing commit command can
be a solution.  For example, skipping the update of next_aggregation_sis and
next_ops_update_sis when the intervals are not changed might be able to solve
the intervals delay problem.

> 
> The wait_for_schemes_apply command causes the calling thread to wait until
> all schemes have been applied. It does this by calling damos_walk() with a
> NULL walk_fn. This can be useful, for example, if a user wants to know when
> new scheme parameters they've committed have been applied. Another use case
> could be if a user wants to record the system state every time a scheme is
> applied for debuging purposes.
> 
> The functionality of wait_for_schemes_apply can be achieved with the
> existing update_schemes_tried_bytes and update_schemes_tried_regions
> commands. However, having a separate command avoids extra work and makes
> user intent clearer when used in scripts.

I agree extra works are always better to be avoided.  But is the overhead large
enough to be a real problem for your use case?  I also agree it could make the
user script cleaner, but adding a kernel feature only for user scripts
readabilities sounds like too much, since the user script could have its own
abstract layers for its readability.

Also, even if the new command is implemented, since the DAMOS schemes continue
running, the system status will keep changing.  If you cannot do the recording
of the system state in a restricted time, the recorded information might not be
that reliable.  So I'm not sure if you really need this strict waiting in this
way.

Could you please share more details about what you want to do with the new
command, and how much problem you are seeing?  I'm particularly curious what
system state you want to record, and why you need to wait the exact time
interval.

Depending on the real use case and the problem, I think we might be able to
reuse the DAMOS scheme stats, or implement more strict and reliable time
control features, say, making kdamond or schemes pause and resume as users ask?


Thanks,
SJ

[...]
