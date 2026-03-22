Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5997E23BD06;
	Sun, 22 Mar 2026 19:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774207978; cv=none; b=IDETEPaN888wrEIXTkFE0Slt1vCnx6WdomxmslluUGMMbZ7VEtyFKkzfY8MxcRTyvUDv1h6oBbiYYLjKtiGZBeLTYDMotVtL4BBn6l2X2YvC5EnluLCyZL0hqHwb0wyJlv3JnAA7lcN7PXcPInDSWLmUJ+UHj6xbdTpqGF4vPdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774207978; c=relaxed/simple;
	bh=3D+LrY1/ynKCWurva4ZNY7JKVhIvr0t2su2LfdfwKQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/E69byd0w6wT5l4Nd3xT35zK5ieMet6w2iUiM7X21hQntUqQ+Za96o/hDUKHZ/9M19jCNUgrtl49i00JV3i0Uy6Zo+rbkFVmiT3LftdzG1ggv1ZGugpsa1VqSSMcwH+vcSt9oxdCWmL3EF6vFKLxS8izovK6FUOvZG0OvFsurA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+FtvOeo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+FtvOeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D06C19424;
	Sun, 22 Mar 2026 19:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774207977;
	bh=3D+LrY1/ynKCWurva4ZNY7JKVhIvr0t2su2LfdfwKQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+FtvOeoVBZccJvJX6KAWADTB1HxETF2bkgp8zlyFw1BX4mG81zosEk5W7kqj7qDz
	 7SaQ6H3DW9dyeM3B+An0Tz3hQqB8k0r0GPUwYcQf+kbQaMxBuAPXNTXfh7iam21x2k
	 l/ymJaJEBpgoCZVxGNbJvSBRqm2cQRTfnseoL6pzOHpJcFW8PMU5U1tO1e28ZziZej
	 /b+pH0rlgioex45VOlI0KA/Ai2zg8joxHqRjgV7T7jUi6/AjqtaXhbmtW8ddBv4lL6
	 0iJAL8r+5LJBRheMVCZUbqPOcoF1nmiqRQEXdIzvL9ipL+crba70Shf0dET1SuR9VV
	 02rO1akKQ45zg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 15 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/core: avoid use of half-online-committed context
Date: Sun, 22 Mar 2026 12:32:55 -0700
Message-ID: <20260322193256.88040-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260322192641.87848-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Mar 2026 12:26:48 SeongJae Park <sj@kernel.org> wrote:
[...]
> Now the feature is available on 'master' branch of hkml.  I started using it
> since yesterday for DAMON patches, and it works for at least my workflow.  The
> documentation is also updated [1].
> 
> [1] https://github.com/sjp38/hackermail/blob/test/USAGE.md#forwarding-sashikodev-statuscomments-to-mailing-list

The above link is broken, sorry.  Please use below.

https://github.com/sjp38/hackermail/blob/master/USAGE.md#sashikodev


Thanks,
SJ

[...]
