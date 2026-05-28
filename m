Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7932D8795;
	Thu, 28 May 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978508; cv=none; b=XoHigy3CGkfpVrBdn3RHzqaPDqMiDH1wO9D8icngFx+J5h5KOWWCAlSBVCtiU+0jD9KmPPCpoVKpVRFd7edJno9TUV9OGu94qL6Ma5WhqjqZKXNSMfGNmgmj/cdfo04C/bPyBqjbYHNGVER71Ykzx0JCtkwOKRkcVAj9zxlkU/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978508; c=relaxed/simple;
	bh=DXcBnuzRR6TbN/RQVt9z5AyZSqXkY6uBffy5ouM7MsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/FXhfhjOGuKH4t5MsqHUQvjkZvx8e5W18IObAm8oZCVwFqdF3W3P+q73jIYrwcXJ1D2xILcPxiGir5inSqf3B7UEyJwfAK3zUk6qaUeX5BmPCrS8gY5HdOuBBe12JNrNX1/jdYP2YnbJVPeq8whOF9RwMRsyi9yMRa5I16zTVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jgef1LBx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgef1LBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493E31F000E9;
	Thu, 28 May 2026 14:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779978507;
	bh=EoTuaugOUgpppVjtGCkMKZAI0joZpdSN429TRVLx6SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jgef1LBxEC9c3bU8HLJOK1NHDewt8wbC75+D/S7/DJ01W+EeJSNc/Z3fJyMjCmCHx
	 3WfXJjMYvCpJ8Pc1GEJOZWN6+nZwRyMvz6DMRHYdUjcBYyxft6OIQv71Mha1ofiSKk
	 JXhABIx2Y/DElhEg2D3cx00BKphVODj6Kc0WYHP0lqvgbWf2X0sPTOe95lNiEt6Y12
	 xVhgE6fQ5FLx+6ILsldfhsFaOuBZXqjktMiaD8zN2FWpt/5cbgp/epRr/T05t2uk+4
	 2gOa5azMHCN7gJFQc5fyr0yGQoZ8hTKQ3t6nK5Gy2s16J1VkxpuprtK6WneKz/Ta/5
	 v8cEL37E65wmg==
From: SeongJae Park <sj@kernel.org>
To: niecheng <niecheng1@uniontech.com>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com
Subject: Re: [PATCH 2/2] selftests/damon: validate memcg filter sysfs readback
Date: Thu, 28 May 2026 07:28:18 -0700
Message-ID: <20260528142819.153573-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <406BD1BA0F6AE326+20260528081039.1192194-3-niecheng1@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello niecheng,


Could we use 'selftests/damn/sysfs.py:' as the prefix of the subject?  That
will make it consistent with other commits and let us easily know to what test
this change is made.

On Thu, 28 May 2026 16:10:39 +0800 niecheng <niecheng1@uniontech.com> wrote:

> Add memcg filter validation to the DAMON sysfs selftest by checking the
> memcg_path sysfs readback.
> 
> Validate the readback path rather than a derived memcg_id so that the
> test stays focused on DAMON sysfs behavior and avoids depending on the
> local userspace cgroup mount layout.

Nice, thank you!

> 
> Also compare the readback path while stripping only the trailing
> newline.
> 
> Signed-off-by: niecheng <niecheng1@uniontech.com>
> ---
>  tools/testing/selftests/damon/sysfs.py | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
> index 3aa5c91548a5..b595da24f698 100755
> --- a/tools/testing/selftests/damon/sysfs.py
> +++ b/tools/testing/selftests/damon/sysfs.py
> @@ -33,6 +33,7 @@ def assert_true(condition, expectation, status):
>      if condition is not True:
>          fail(expectation, status)
>  
> +
>  def assert_watermarks_committed(watermarks, dump):
>      wmark_metric_val = {
>              'none': 0,
> @@ -90,8 +91,14 @@ def assert_filter_committed(filter_, dump):
>      assert_true(filter_.type_ == dump['type'], 'type', dump)
>      assert_true(filter_.matching == dump['matching'], 'matching', dump)
>      assert_true(filter_.allow == dump['allow'], 'allow', dump)
> -    # TODO: check memcg_path and memcg_id if type is memcg
> -    if filter_.type_ == 'addr':
> +    if filter_.type_ == 'memcg':
> +        shown, rd_err = _damon_sysfs.read_file(
> +                os.path.join(filter_.sysfs_dir(), 'memcg_path'))
> +        if rd_err is not None:
> +            fail('memcg_path sysfs read', {'error': rd_err})
> +        assert_true(shown.rstrip('\n') == ('%s' % filter_.memcg_path),
> +                    'memcg_path_sysfs', dump)
> +    elif filter_.type_ == 'addr':
>          assert_true([filter_.addr_start, filter_.addr_end] ==
>                      dump['addr_range'], 'addr_range', dump)
>      elif filter_.type_ == 'target':

But this is in the middle of assert_filter_committed().  As the name says, this
is for validating if the user inputs are passed to DAMON internal.  I think
this is not the right place to test its 'staging' functionality.

> @@ -258,6 +265,8 @@ def main():
>                  ops_filters=[
>                      _damon_sysfs.DamosFilter(type_='anon', matching=True,
>                                               allow=True),
> +                    _damon_sysfs.DamosFilter(type_='memcg', matching=True,
> +                                             allow=True, memcg_path='/'),
>                      ],
>                  )])
>      context.idx = 0

What about adding another test case at the end of the main() function for the
validation of memcg string staging functionality?


Thanks,
SJ

[...]
