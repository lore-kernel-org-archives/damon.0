Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E3284B29;
	Sun, 29 Mar 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774799379; cv=none; b=WJzOagKbY+BH9yUvEzpoefSd/WITAm3YeoV+TAa76EleRSXIAS0pM4SFfUVbPMvwXGr/AuVgqi8YlJI4YW1HZ6ljgRoh0bsSW2gya5Ht58DCRpY73nhWlFO4cIL5gmkS5ZD47k0zByydA+nBbE4Ydw6lCv+xbE1FHWAGnK1ADbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774799379; c=relaxed/simple;
	bh=ZlPTTq6A7hzTBwvtr1yc4gLjYsyrTWFBrDRXyxAL2rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6GxgCDR+YGyU+57z3YFu2Ntykv4cpuzNs0xhpn2iZcILeous66uIsn11+dRFCdcSCP6FR2ToQuoZHtsdi2bs2eQ6waTQnfgXqdRgyulUjHIuGmNbue34QwbBYL0ItSbv0QS1wCxz/UlyhI5blTDeg4BwWkPCh42vs7iK2zOfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRAwzZcD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRAwzZcD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A184C116C6;
	Sun, 29 Mar 2026 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774799378;
	bh=ZlPTTq6A7hzTBwvtr1yc4gLjYsyrTWFBrDRXyxAL2rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRAwzZcDa4xWkzBPdlwJK55mF2P9NzFn+1tUk258au2qXsvaBVmC/XnB+pF945B07
	 f4tkwLLa0OJThp56SIgkPhz0rMzz4d5GEksISRcVw9drEVIMfQNo+DI8AOKWln3nSB
	 QWOAAo2mjg62anKWFvC1V5FryRgRjkpFXdwKdS795yW234UwoBEHHaBR8n7dcflbzE
	 2ZbxgHyWnuR+tVo7qtwayL1g1ZKdJ6GVKcdPmXLoEQ150pUKPr8y7n8fJz380pZtBq
	 o3gmRQx35K/LquBsgPJKLnt/NSmpPfIXi0/H1StNtG9XqxVFtRcBVFgZFZFqkbpcTa
	 EaRoNMRVQrLUQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH 1/2] Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race
Date: Sun, 29 Mar 2026 08:49:36 -0700
Message-ID: <20260329154937.47706-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329153052.46657-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260329153052.46657-2-sj@kernel.org
# start of sashiko.dev inline review
commit 140a828ed89f6ed59d7b68f9bb0f1ec9b051eec7
Author: SeongJae Park <sj@kernel.org>

Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race

This commit adds documentation warning users not to update DAMON reclaim
module parameters while a commit_inputs request is in progress. It notes
that doing so can cause undefined behavior due to races with the kdamond
thread reading those parameters.

Link: https://lore.kernel.org/20260319161620.189392-3-objecting@objecting.org

> diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
> index 47854c461706..d7a0225b4950 100644
> --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
[ ... ]
> @@ -71,6 +71,10 @@ of parametrs except ``enabled`` again.  Once the re-reading is done, this
>  parameter is set as ``N``.  If invalid parameters are found while the
>  re-reading, DAMON_RECLAIM will be disabled.
>  
> +Once ``Y`` is written to this parameter, the user must not write to any
> +parameters until reading ``commit_inputs`` again returns ``N``.  If users
> +violate this rule, the kernel may exhibit undefined behavior.

Is it acceptable to rely on documentation to prevent undefined behavior
triggered by userspace?

If users write to sysfs parameters concurrently, can it still crash the
kernel? For example, in damon_reclaim_apply_parameters(), the code verifies
if (!damon_reclaim_mon_attrs.aggr_interval) to prevent division by zero. If
a user concurrently writes 0 to the parameter via sysfs immediately after
this check but before damon_reclaim_new_scheme() executes, wouldn't the
subsequent .min_age_region = min_age / damon_reclaim_mon_attrs.aggr_interval
calculation result in a divide-by-zero kernel panic?

Should this race be fixed in the code using synchronization primitives
rather than adding a documentation warning?


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260329153052.46657-2-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260329153052.46657-2-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
