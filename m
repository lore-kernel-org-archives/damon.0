Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BCF15C0
	for <damon@lists.linux.dev>; Sun,  3 Aug 2025 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754243095; cv=none; b=nbHs9BVTTW+Evkno9roKJnZrZ+vhIE/UMo6p8xQmkhvJszHguBt6iIS3Oc0tqa46PTRtE1iHvpHU9YhkqsKyZ2CInia3iP9FJD5WRSgOH5JUBZptO0deF4EtMrlgiKRFsmiv8q+cKG7TwX0nwlKXyENISsPpZLKxSb++K/U4zb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754243095; c=relaxed/simple;
	bh=NKIW0KmkhulZ8wcVAHMvOOyte2iSuqOly8sWZxer5wU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mQSpQHSbEYVk3sMrzjknRDT5d7e2s9+L6HUxFtD7MAq1eLQc2RRC8SnqHmjmvPQUbyH6B6ZaQ8YyiSqvTCYWFfqJHgG0TFmF0b5FKbIhyOWpY6peL84OiGXPMtf3btuo74o5xRkukhZAyOOfMZKfl1P9UFQM0M7WRkqdFcn/cjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Djj2CoRv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Djj2CoRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A49FC4CEEB;
	Sun,  3 Aug 2025 17:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754243095;
	bh=NKIW0KmkhulZ8wcVAHMvOOyte2iSuqOly8sWZxer5wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Djj2CoRvwrEUGErYkMnDFIUiRK6FGok3ZQUD39W5XWbRMDHYfupn1SGswwPR0Vygl
	 Nf3zbojho4H07ytJ5rEUR3yo98Cb+tnyz1kQ+mltMuSYVge0euZVFYeX26HYmCPz8M
	 kt0w+SHT5D6iH6ZvjcNa5AUC8wh1he+8cgH0bB3JpbPud3fwew8QnxoGRzPEfQaOxg
	 /XF7T+wt5RhGsKZONMgqX1X4KWnom+wsVBYuQmF+QvqMZ4IQBu+uQ35LWnXvfVHoYK
	 qLe2PmjAEO2WL9Xo6KH2obaxrah0S/axcLqOSS44rCh6ijx+mrxd6OcaXgTv8DmNL1
	 wlO2BqlizLM9w==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: update expired description of damos_action
Date: Sun,  3 Aug 2025 10:44:52 -0700
Message-Id: <20250803174452.55944-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CABFDxMGUO88-CkHa8E79TTkoEm_j5FX3ZBVjChXJ5w0eL3mNSA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 3 Aug 2025 21:44:10 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

[...]
> When the discussion of "reclaim" finishes, I'll make v2 patch as soon
> as possible.

As mentioned on the other reply, I don't think the v2 should be blocked for the
discussion, unless Honggyu or others object.


Thanks,
SJ

[...]
