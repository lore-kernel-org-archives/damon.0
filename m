Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2DC33A03A;
	Sun, 17 May 2026 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039762; cv=none; b=P6rghokparmhNUtee+ff0ETqA0AfEajQA/cs+r9a40Gl+nVgoH0Lodysz6sV39PyvCOTBv0/2wyM3Kj7eXuH+MkmND+Trs9vcLR5xFhVE37qDO1c5HPVcSQDYBG9WgFL6jfvtcZA45g8lfrfxe9Tbcka9kkp5vbksTbQxBExvlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039762; c=relaxed/simple;
	bh=mIIt+rPrya9rA0KovBDgwi0sHwBa4TedHEoMg1kEOwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5k6gnGoLVX7zOLWI+0DGEJx/PkIghMqJPg/amj7j9pMIsV8R+u52cf6B5W0l8ksCJ7s1BSnITsQhAFOn6EmqNvIQk6MhOd8DZoZSybord9lT/czGqlEWfX4v/Z+dVo8ul7vvxpFCJ7rtZj1vabAVuDaRvRFYOlVbsEeZVNT4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkaJhxGY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkaJhxGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DACFC2BCB0;
	Sun, 17 May 2026 17:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779039762;
	bh=mIIt+rPrya9rA0KovBDgwi0sHwBa4TedHEoMg1kEOwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KkaJhxGYX7lgZ9F9mKGUyhfhH7wkdWbaD0WNwKVI1tx6HVzkLhKss6TJSc8gFRxzA
	 pB40KUWixstWeCK1cjYCyYvDOzTPzBAp/oaoU7/GP2499OW9W3dGaTXR6nSVSAlKUt
	 Qp6JbD1ge0AX2m3ZTwRGfzS567WKH+j2gxlheV3priVgBwI8HH5k7vYLwRxpVdtj5M
	 cUo2mJVsjMzK1jgKQkpaO9jy9kt029Re1ns/B0LzQUUPUt5RIs39y0j+8K5FlJyT11
	 ttZTh1VsqGnsCOSFM9hmaHLURZRg2SFcsE1uAXDtmsVTmfa4MZHdejBGKzI8+LJMvr
	 hxtr/YrWi7d3A==
From: SeongJae Park <sj@kernel.org>
To: Sakurai Shun <ssh1326@icloud.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] design: fix typos in design.rst
Date: Sun, 17 May 2026 10:42:32 -0700
Message-ID: <20260517174233.1595-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260517073433.3015-1-ssh1326@icloud.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Sakurai,


Thank you for sending v2 of this patch!

As I commented [1] to the previous version, let's use 'Docs/mm/damon/design:'
as the prefix of the subject, e.g., "Docs/mm/damon/design: fix three typos"

On Sun, 17 May 2026 16:34:26 +0900 Sakurai Shun <ssh1326@icloud.com> wrote:

> L140: "unsinged" -> "unsigned"
> L371: "sampleing" -> "sampling"
> L387: "multipled" -> "multiplied"
> 
> Signed-off-by: Sakurai Shun <ssh1326@icloud.com>

Assuming the subject prefix suggestion is accepted,

Reviewed-by: SeongJae Park <sj@kernel.org>

If you willing to, please send v3 with the change.  But please do so after
giving time (say, one day?) for others to further comment.

Unless you object to the subject prefix change suggestion, Andrew might pick
this after making the subject line change on his own.  I will also pick this
with my subject line change suggestion on my tree (damon/next), and repost it
for mm.git inclusion if it seems Andrew will not do so.

So, assuming you are ok with my subject line change suggestion, no more work
from your side is needed (unless you willing to do some).  Thank you for your
contribution, Sakurai :)

> ---

Also, from the next time, please add patch changelog here [2].


[1] https://lore.kernel.org/20260516170847.146524-1-sj@kernel.org
[2] https://docs.kernel.org/process/submitting-patches.html#commentary


Thanks,
SJ

[...]
