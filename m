Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0B30100E;
	Sun, 29 Mar 2026 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774799359; cv=none; b=IghMdewiEH6DMREkwyBhlx4wNoSOkQXchr7boQnZqtVrgogOF4akUrTJopTPhggTojJIpt69zhxSizG6K0eqb+IrGTmhMsJBHdG6SqF9zfimqHYGGrgHkCBx4rXI5tK3wknwzUXZvYtsPExNPd82TH0kaCKObyNz+/W4rBqT+N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774799359; c=relaxed/simple;
	bh=6BPfdPDs7/l+xDR+dNdtis6DP9JbpaorqMtRKxNtuM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObVFsPdiNI3ZYxReIYKkrWgZG+J5y+vLfXtoN0Gun2Mpw7nVMJua5JGDbK8DhANy8pZHK4IKmA2tAsUAUOfqOpKmeYcSw+yHsfzWlzmOr1QnnueMNLqgNXD/Hpe6e37LgFU/WalEE7rbgIZtMtSNgOPWAYzH081r/2cQ4sZ4Uzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ER4wWjgc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER4wWjgc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871D8C116C6;
	Sun, 29 Mar 2026 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774799358;
	bh=6BPfdPDs7/l+xDR+dNdtis6DP9JbpaorqMtRKxNtuM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ER4wWjgcXPZwscYw59MA7J/+z6DhevaDOFlgQJvNWEOta4P1bYnMv80z3lJKkfVcr
	 zL7OA+tRbt6pZKJI9fOAGLb8RP5vDFBSmqQaFMkaQRvGv/8OMLzLiPzkg5ZI1iZqon
	 OokRBc4q3wuMS6e9nAyKX5h9wl8y0qXj7y/5/p2Z16+jEoEEROIttf6TNYIWFf1UPI
	 FcgoFP2iBp9/HmYX3EtGfaVPCGnTYCIMuIjjJ0kXGwagSLmOoSi5cnefcJIUTynL9r
	 WLTf8aMu9c5QA4l4RjCeZbyLDwdNsjnp9b9IVLVEHCchNBLcTWnLqTdz9eORWFmaAU
	 VksLT5PqSd6lA==
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
Subject: Re: (sashiko status) [PATCH 0/2] Docs/admin-guide/mm/damon: warn commit_inputs vs other params race
Date: Sun, 29 Mar 2026 08:49:16 -0700
Message-ID: <20260329154917.47598-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329153052.46657-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Forwarding sashiko.dev review status for this thread.

# review url: https://sashiko.dev/#/patchset/20260329153052.46657-1-sj@kernel.org

- [PATCH 1/2] Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race
  - status: Reviewed
  - review: ISSUES MAY FOUND
- [PATCH 2/2] Docs/admin-guide/mm/damon/lru_sort: warn commit_inputs vs param updates race
  - status: Reviewed
  - review: ISSUES MAY FOUND

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260329153052.46657-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)
