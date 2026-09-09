Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF481E5B70;
	Wed,  9 Sep 2026 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912865; cv=none; b=fHtliQpQrf6SYYFOIFdcr4T7/fRZYt6/LhfbNdFp5MNFxVi+8vx8wE0lWZykh/01gjtNe32O105nAvuN0JGcmkO6BNvshzDzlm23hzY/JQv31n1zK0fY/3bwSpBtsIhYaOkwumgfrHQdS69gNkEsxLTT/UbDbXSAdOAVJB/sCmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912865; c=relaxed/simple;
	bh=fa4PJg8XyE4dlMfirn5fVm7xejt2aIWLMmUkxEezsfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OC1D6UjEG7sJNipbfL2+cLTQXK7MIR6DzwgcOAlSFGipE0Hkv0gwFGPyBYCJzOSyuSLG+5wYCb3n9caBtgbMtW8w5cnOvQMHbPpIz06457bHemnrPeagUhrLjm8tnDrnHHqrvuzaJEHScDMVge4FlOsTWuaGpoZKJWrOkRJ7ZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=av2lBcXH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="av2lBcXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC711F00A3A;
	Wed,  9 Sep 2026 00:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788912864;
	bh=FNI1Vu5xWgBc1XMbL6PII/w18t/G/EnGzJaA9l5f4go=;
	h=From:To:Cc:Subject:Date;
	b=av2lBcXHcLSDIN9vJqaTfDCpwq/aj0jcD77rR8IgRLZ8l6N36dfI6WINmE/76CkQ4
	 n0PCsbttXl0PFUT2T3wFKpftgTWzFqNJHfOmDpLwe06wbOjJxFPaVJLP+qIAvwCilz
	 TbXEpBV58ijMf/DhDgKPeqCO4nvzSuPhWAkhxbeWM+3na73XyqkBkc0UasUm5FsmAc
	 oXSKLjOCjNGwg43JAlR9bN7Ozwx8TploFU+9adOOwy4TD6wu429fjVKEZ9+6epekCY
	 Purk6XQbWa7IAXiD0akiZS1t9faNpd7l7l+oUAKFuTzFqLEMUwnQxRacLemKab/+WW
	 8qJJXpcr6b6xw==
From: SJ Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Fifth DAMON merge anniversary
Date: Tue,  8 Sep 2026 17:14:11 -0700
Message-ID: <20260909001411.107286-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Five years ago today, DAMON was merged [1] into the mainline.  The last five
years were so grateful and incredible time to me.  I earned many lessons and
friends, much more than I expected.  It was all owing to the great DAMON
community.  According to my humble script [2], 143 people contributed 1,427
commits and 49,123 lines of changes to DAMON in the last five years.

    $ ./lazybox/version_control/authors.py ./linux --since v5.14 \
            --linux_subsystems DAMON --skip_merge_commits --total_only
    # 143 authors, 1427 commits in total
    $ ./lazybox/version_control/authors.py ./linux --since v5.14 \
            --linux_subsystems DAMON --sortby lines --skip_merge_commits \
            --total_only
    # 143 authors, 49123 lines in total

Huge thanks to all the contributions.  Hopefully DAMON didn't only take but
also gave some fun and wins to people.  I will also try to give back more to
the community.  I'm looking forward to the next five years.

[1] https://git.kernel.org/torvalds/c/2224d8485492
[2] https://github.com/sjp38/lazybox/blob/master/version_control/authors.py


Thanks,
SJ
