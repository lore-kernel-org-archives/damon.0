Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3B72135CE;
	Fri, 21 Nov 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742950; cv=none; b=pd9yKkN6oeVfvT4tzxks0QMLZbR8GG2MXiE7Bnkd4gq1KaevcyOPzc6mieo5bx20M9B51f1SIVFlnHitLx9+t3IiQ77VssgNLKYBlfsmD1rgws/YXDPHBNqiiNJ23njvwK2NPxQK2Q9gw/cn3JlKdQKafmxh7CdHWyF44WYSCVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742950; c=relaxed/simple;
	bh=+j8+cMczWh+41I829ullX5nvOYe6iNeHAFyjPVtK8uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKOk+lpkOEfqUuin1iODJmzqJxafBU2IAelQIEwfK0W2fUMhbQ6qxnSLc0yDndxB7prMu3c8H5YsFXORWLmMea7/qEFZVyax2/IgN8YFZZpS1HfKnb8h3iG+7TbwCoQYRz92xMC2iD9wu4DXj2tUAD5W0mU1DET5buYdCcD+9sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHl3689/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHl3689/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD77C4CEF1;
	Fri, 21 Nov 2025 16:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763742950;
	bh=+j8+cMczWh+41I829ullX5nvOYe6iNeHAFyjPVtK8uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHl3689/H54OfwlPu5yp23DklYBUo2cq+4BzC2d3rEQtYa2AeaCtTsqga8TWnwP+a
	 PY/b3CXBUEB8lH+wn2HTP0u/tI5kaWXgXSb3IbgScl6O0r0fxMQ9aLLptL3sO5vabK
	 zVQybjGesYOSZHYRmI8KfPAjCU7Hi1RJq6ppWnMRwLMyCdYLBqLjWHfa1jL4nw7HSS
	 vixRtfiGJh+sJvOjXZU4Xk0MKNaaTTsQC1pNFd9ohNIz+1O8RU3ct22IY0qzq7xRZ3
	 YumK7D2L6sJNviUR5UZsMttZn1BFACsZ+eWI1XXearxItD15TmnEk9mkDlJRrDNA57
	 PyroJFutNQ1NA==
From: SeongJae Park <sj@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] mm/damon/tests/sysfs-kunit: fix use after free on error path
Date: Fri, 21 Nov 2025 08:35:41 -0800
Message-ID: <20251121163542.137692-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aSBq5uSPIqsqH8zO@stanley.mountain>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 21 Nov 2025 16:36:38 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:

> Re-order these frees to avoid dereferencing "sysfs_target" after it has
> been freed.

Thank you for finding and fixing this!

> 
> Fixes: ee131696794c ("mm/damon/tests/sysfs-kunit: handle alloc failures on damon_sysfs_test_add_targets()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
