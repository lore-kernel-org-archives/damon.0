Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CA717759
	for <damon@lists.linux.dev>; Fri,  2 Jun 2023 19:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C52DC433D2;
	Fri,  2 Jun 2023 19:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685733304;
	bh=nvI5b9+cPLi2PS/bEHgXWPypYY86IfgngWve0OOt7NE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VyrSXRquTV2qNouSGpvHl+kfHGft0KqVV/S9F2uqljKRYIVKfNWB5wjnKBCafZEKY
	 qpNrG4qUV923ZQ0jIOXAPyVfKn/UMm65epFbuDDl79DspGaIRvjzssBFoan3gnvsHR
	 ExuMGhjci67ldTTmrTjD4Ou7O5XGNoJwC+kVRkqSi89heBGnKhaTkikovA7eOjMMrN
	 oiKRR5E+h63p+YwoDFUHEyiqCgd9/xw+M/g7X3lmd5+94pWWIzEsbOlJTpVG1XHcsd
	 DkfKxrJCGjHxFajPCJEnydxcEsCy2URDBud+z5fFDkZBvIyQrvaIbqX28hOjk8T1GD
	 17x4x3kDyfJGg==
From: SeongJae Park <sj@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev
Subject: Re: [PATCH v3 2/4] mm/damon/ops-common: atomically test and clear young on ptes and pmds
Date: Fri,  2 Jun 2023 19:15:01 +0000
Message-Id: <20230602191501.85553-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <640f81aa-035e-9f42-c848-096e4c9e014c@arm.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ryan,

On Fri, 2 Jun 2023 18:14:25 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> On 02/06/2023 17:35, Yu Zhao wrote:
> > On Fri, Jun 2, 2023 at 3:30 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>
> >> It is racy to non-atomically read a pte, then clear the young bit, then
> >> write it back as this could discard dirty information. Further, it is
> >> bad practice to directly set a pte entry within a table. Instead
> >> clearing young must go through the arch-provided helper,
> >> ptep_test_and_clear_young() to ensure it is modified atomically and to
> >> give the arch code visibility and allow it to check (and potentially
> >> modify) the operation.
> >>
> >> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces").
> > 
> > Just to double check: was "Cc: stable@vger.kernel.org" overlooked or
> > deemed unnecessary?
> 
> It was overlooked - incompetance strikes again! I was intending to cc the
> whole series.

Not the whole patches in this series but only this patch is intended to be
merged in stable series, right?  If I'm not wrong, you could add
'Cc: <stable@vger.kernel.org>' tag here[1] when resending, to let stable kernel
maintainers easily understand exactly what patches should be merged in the
stable kernels.  So, you wouldn't need to touch coverletter or cc whole series
but only this one.

[1] https://www.kernel.org/doc/html/v4.10/process/stable-kernel-rules.html


Thanks,
SJ

> What's the best way to fix this? Can I just add stable in cc on reply to
> the cover letter or will I have to resend the lot?
> 
> > 
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >> Reviewed-by: Zi Yan <ziy@nvidia.com>
> >> Reviewed-by: SeongJae Park <sj@kernel.org>
> >> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
